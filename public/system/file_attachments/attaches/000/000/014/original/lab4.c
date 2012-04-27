#include <sched.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <math.h>
#define DATA 1
#define RESULT 2
#define FINISH 4
#define BOOL int
#define TRUE 1
#define FALSE 0
#define THREADNUM 4

int globalRank;

const double RangeSize = 15;
const double Precision = 100000;
const int InitialDistribution = 3;

typedef struct
{
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	BOOL triggered;
} SMREvent;

typedef struct
{
	double start;
	double end;
	int val;
} SData;
void incrementRange(SData* range)
{
	range->start = range->end;
	range->end += RangeSize;
	if(range->end > Precision)
		range->end = Precision;
}

struct SDataQueueNode
{
	SData val;
	struct SDataQueueNode* next;
};
typedef struct SDataQueueNode SDataQueueNode;

typedef struct
{
	SData val;
	BOOL isNull;
} SPopRet;

typedef struct
{
	SDataQueueNode* first;
	SDataQueueNode* last;
	sem_t semaphore;
} SDataQueue;

typedef struct
{
	SMREvent* queueEvent;
	SDataQueue* queue;
	BOOL* cancelRequest;
} SSlaveThreadData;

typedef struct
{
	SSlaveThreadData* data;
	pthread_t* threads;
	int count;
} SSlaveThreads;

typedef struct
{
	SMREvent* queueEvent;
	SDataQueue* queue;
	int proccount;
	double* result;
	BOOL* isSentCountDetermined;
	int* sentCount;
} SMasterThreadData;

double computePiPart(int fac);
void master(int proccount);
SSlaveThreads startSlaves();
void waitForSlavesAndFree(SSlaveThreads slaveThreads);
void slave();
///////////
void InitializeQueue(SDataQueue* queue);
void PushQueue(SDataQueue* queue, SData data);
SPopRet PopQueue(SDataQueue* queue);
////////////
void mrevent_init(SMREvent* ev);
void mrevent_set(SMREvent* ev);
void mrevent_reset(SMREvent* ev);
void mrevent_wait(SMREvent* ev);
///////////////
sem_t gsb_semaphore;
BOOL GetThreadSafe(BOOL* b);
void SetThreadSafe(BOOL* b, BOOL val);
///////////////

int main(int argc, char **argv)
{
	int myrank, proccount, threadsupport;

	MPI_Init_thread(&argc, &argv,MPI_THREAD_MULTIPLE,&threadsupport);
	if (threadsupport!=MPI_THREAD_MULTIPLE)
	{
		printf("\nThe implementation does not support MPI_THREAD_MULTIPLE, it supports level %d\n",threadsupport);
		MPI_Finalize();
		exit(-1);
	}
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
	MPI_Comm_size(MPI_COMM_WORLD, &proccount);

	if (proccount < 2)
	{
		printf("Run with at least 2 processes");
		MPI_Finalize();
		return -1;
	}
	if ( (Precision/RangeSize) < 2*(proccount-1) )
	{
		printf("More subranges needed");
		MPI_Finalize();
		return -1;
	}

	sem_init(&gsb_semaphore, 0, 1);

	globalRank = myrank;

	if (myrank == 0)
		master(proccount);
	else
		slave();

	MPI_Finalize();
	return 0;
}

void* masterReceive(void *args)
{
	SMasterThreadData* data = (SMasterThreadData*)args;
	SData nextSlave;
	double resulttemp;
	int i, j, flag, receivedCount = 0;
	MPI_Status status;

	while(1)
	{
		if(*data->isSentCountDetermined && receivedCount >= *data->sentCount)
			break;

		MPI_Probe(MPI_ANY_SOURCE, RESULT, MPI_COMM_WORLD, &status);
		MPI_Recv(&resulttemp, 1, MPI_DOUBLE, MPI_ANY_SOURCE, RESULT, MPI_COMM_WORLD, &status);

		++receivedCount;
		*data->result += resulttemp;
		nextSlave.val = status.MPI_SOURCE;
		PushQueue(data->queue, nextSlave);
		mrevent_set(data->queueEvent);
	}
}

void* masterDistribute(void *args)
{
	SMasterThreadData* data = (SMasterThreadData*)args;

	int i, j, sentCount = 0;
	SData currentRange;
	SPopRet popRet;
	MPI_Status status;

	currentRange.start = 0;
	currentRange.end = 0;
	for(j = 0;j < InitialDistribution;++j)
	{
		for(i = data->proccount-1; i >= 0; --i, ++sentCount)
		{
			incrementRange(&currentRange);
			MPI_Send(&currentRange, sizeof(SData), MPI_BYTE, i, DATA, MPI_COMM_WORLD);
		}
	}

	while(currentRange.end < Precision)
	{
		popRet = PopQueue(data->queue);
		if(!popRet.isNull)
		{
			incrementRange(&currentRange);
			MPI_Send(&currentRange, sizeof(SData), MPI_BYTE, popRet.val.val, DATA, MPI_COMM_WORLD);
			++sentCount;
			++i;
		}
		else
		{
			mrevent_wait(data->queueEvent);
			mrevent_reset(data->queueEvent);
		}
	}

	*data->sentCount = sentCount;
	*data->isSentCountDetermined = TRUE;

	for(i = data->proccount-1; i >= 0; --i)
		MPI_Send(NULL, 0, MPI_DOUBLE, i, FINISH, MPI_COMM_WORLD);
}

void master(int proccount)
{
	SDataQueue queue;
	SMREvent queueEvent;
	double result = 0;
	int sentCount = 0;
	BOOL isSentCountDeterminded = FALSE;

	SMasterThreadData masterThreadData;
	pthread_t masterThreadDistribute;
	pthread_t masterThreadReceive;
	pthread_attr_t attr;
	void* threadstatus;

	SSlaveThreads slaveThreads = startSlaves();

	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

	InitializeQueue(&queue);
	mrevent_init(&queueEvent);

	masterThreadData.proccount = proccount;
	masterThreadData.result = &result;
	masterThreadData.queue = &queue;
	masterThreadData.isSentCountDetermined = &isSentCountDeterminded;
	masterThreadData.sentCount = &sentCount;
	masterThreadData.queueEvent = &queueEvent;

	pthread_create(&masterThreadDistribute, &attr, masterDistribute, &masterThreadData);
	pthread_create(&masterThreadReceive, &attr, masterReceive, &masterThreadData);

	waitForSlavesAndFree(slaveThreads);
	pthread_join(masterThreadReceive, &threadstatus);
	pthread_join(masterThreadDistribute, &threadstatus);

	printf("\n\n======>result: %.20f\n", result * 4);
}

void* slaveReceive(void *args)
{
	MPI_Status status;
	SData tempRange;
	int i, flag, resCnt = 0;
	SSlaveThreadData* data = (SSlaveThreadData*)args;

	while(1)
	{
		MPI_Iprobe(MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, &flag, &status);
		if(flag==0)
		{
			sched_yield();
			continue;
		}

		if(status.MPI_TAG == FINISH)
		{
			MPI_Recv(NULL, 0, MPI_DOUBLE, MPI_ANY_SOURCE, FINISH, MPI_COMM_WORLD, &status);
			SetThreadSafe(data->cancelRequest, TRUE);
			mrevent_set(data->queueEvent);
			break;
		}
		else if(status.MPI_TAG == DATA)
		{
			MPI_Recv(&tempRange, sizeof(SData), MPI_BYTE, 0, DATA, MPI_COMM_WORLD, &status);
			PushQueue(data->queue, tempRange);
			mrevent_set(data->queueEvent);
		}
	}
}

void* slaveCalculate(void *args)
{
	int a, b;
	SData tempRange;
	SPopRet popRet;
	double result;
	SSlaveThreadData* data = (SSlaveThreadData*)args;

	while(1)
	{
		popRet = PopQueue(data->queue);
		if(popRet.isNull)
		{
			if(GetThreadSafe(data->cancelRequest))
			{
				//crutial, without this _set other thread will continue hanging on wait
				mrevent_set(data->queueEvent);
				break;
			}
			else
			{
				mrevent_wait(data->queueEvent);
				mrevent_reset(data->queueEvent);
				continue;
			}
		}

		tempRange = popRet.val;

		result = 0;
		a = (int)tempRange.start;
		b = (int)tempRange.end;

		for (; a < b; ++a)
			result += computePiPart(a);

		MPI_Send(&result, 1, MPI_DOUBLE, 0, RESULT, MPI_COMM_WORLD);
	}
}

SSlaveThreads startSlaves()
{
	int i;
	SSlaveThreads slaveThreads;
	pthread_attr_t attr;

	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

	slaveThreads.count = THREADNUM+1;
	slaveThreads.threads = (pthread_t*)malloc(slaveThreads.count*sizeof(pthread_t));
	slaveThreads.data = (SSlaveThreadData*)malloc(sizeof(SSlaveThreadData));
	slaveThreads.data->queue = (SDataQueue*)malloc(sizeof(SDataQueue));
	slaveThreads.data->queueEvent = (SMREvent*)malloc(sizeof(SMREvent));
	slaveThreads.data->cancelRequest = (BOOL*)malloc(sizeof(BOOL));

	InitializeQueue(slaveThreads.data->queue);
	mrevent_init(slaveThreads.data->queueEvent);
	*slaveThreads.data->cancelRequest = FALSE;

	pthread_create(&slaveThreads.threads[0], &attr, slaveReceive, slaveThreads.data);
	for (i=1;i<slaveThreads.count;++i)
		pthread_create(&slaveThreads.threads[i], &attr, slaveCalculate, slaveThreads.data);

	return slaveThreads;
}

void waitForSlavesAndFree(SSlaveThreads slaveThreads)
{
	int i;
	void* threadstatus;
	for (i=0;i<slaveThreads.count;++i)
		pthread_join(slaveThreads.threads[i], &threadstatus);
	free(slaveThreads.threads);
	free(slaveThreads.data->queue);
	free(slaveThreads.data->queueEvent);
	free(slaveThreads.data->cancelRequest);
	free(slaveThreads.data);
}

void slave()
{
	SSlaveThreads slaveThreads = startSlaves();
	waitForSlavesAndFree(slaveThreads);
}

double computePiPart(int fac)
{
	double sign, base;
	base = ((double)fac * 2) + 1;
	sign = (fac % 2) ? -1 : 1;
	return sign/base;
}

//////////////////////////////////////////////////////////////////queue
void InitializeQueue(SDataQueue* queue)
{
	queue->first = NULL;
	queue->last = NULL;
	sem_init(&queue->semaphore, 0, 1);
}

BOOL IsQueueEmptyUnsafe(SDataQueue* queue)
{
	if(queue->first==NULL)
		return TRUE;
	return FALSE;
}

void PushQueue(SDataQueue* queue, SData data)
{
	SDataQueueNode* node = (SDataQueueNode*)malloc(sizeof(SDataQueueNode));;
	node->val = data;
	node->next = NULL;

	sem_wait(&queue->semaphore);
	if(IsQueueEmptyUnsafe(queue)==TRUE)
	{
		queue->first = node;
		queue->last = node;
	}
	else
	{
		queue->last->next = node;
		queue->last = node;
	}
	sem_post(&queue->semaphore);
}

SPopRet PopQueue(SDataQueue* queue)
{
	SDataQueueNode* popped;
	SPopRet ret;
	ret.isNull = TRUE;

	sem_wait(&queue->semaphore);
	if(IsQueueEmptyUnsafe(queue)==FALSE)
	{
		popped = queue->first;
		if(popped==queue->last)
		{
			queue->first = NULL;
			queue->last = NULL;
		}
		else
			queue->first = popped->next;

		sem_post(&queue->semaphore);	

		ret.val = popped->val;
		ret.isNull = FALSE;
		free(popped);
	}
	else
		sem_post(&queue->semaphore);	

	return ret;
}
///////////////////////////////
void mrevent_init(SMREvent* ev)
{
	pthread_mutex_init(&ev->mutex, 0);
	pthread_cond_init(&ev->cond, 0);
	ev->triggered = FALSE;
}
void mrevent_set(SMREvent* ev)
{
	pthread_mutex_lock(&ev->mutex);
	ev->triggered = TRUE;
	pthread_cond_signal(&ev->cond);
	pthread_mutex_unlock(&ev->mutex);
}
void mrevent_reset(SMREvent* ev)
{
	pthread_mutex_lock(&ev->mutex);
	ev->triggered = FALSE;
	pthread_mutex_unlock(&ev->mutex);
}
void mrevent_wait(SMREvent* ev)
{
	pthread_mutex_lock(&ev->mutex);
	while (!ev->triggered)
		pthread_cond_wait(&ev->cond, &ev->mutex);
	pthread_mutex_unlock(&ev->mutex);
}
///////////////////////////////
BOOL GetThreadSafe(BOOL* b)
{
	BOOL val;
	sem_wait(&gsb_semaphore);
	val = *b;
	sem_post(&gsb_semaphore);
	return val;
}
void SetThreadSafe(BOOL* b, BOOL val)
{
	sem_wait(&gsb_semaphore);
	*b = val;
	sem_post(&gsb_semaphore);
}
