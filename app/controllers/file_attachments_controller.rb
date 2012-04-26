class FileAttachmentsController < ApplicationController
  # GET /file_attachments
  # GET /file_attachments.json
  def index
    @file_attachments = FileAttachment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_attachments }
    end
  end

  # GET /file_attachments/1
  # GET /file_attachments/1.json
  def show
    @file_attachment = FileAttachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_attachment }
    end
  end

  # GET /file_attachments/new
  # GET /file_attachments/new.json
  def new
    @file_attachment = FileAttachment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_attachment }
    end
  end

  # GET /file_attachments/1/edit
  def edit
    @file_attachment = FileAttachment.find(params[:id])
  end

  # POST /file_attachments
  # POST /file_attachments.json
  def create
    @file_attachment = FileAttachment.new(params[:file_attachment])
    #@file_attachment.note_id = params[:note_id]
    #print "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    print params
    respond_to do |format|
      if @file_attachment.save
        format.html { redirect_to @file_attachment, notice: 'File attachment was successfully created.' }
        format.json { render json: @file_attachment, status: :created, location: @file_attachment }
      else
        format.html { render action: "new" }
        format.json { render json: @file_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /file_attachments/1
  # PUT /file_attachments/1.json
  def update
    @file_attachment = FileAttachment.find(params[:id])

    respond_to do |format|
      if @file_attachment.update_attributes(params[:file_attachment])
        format.html { redirect_to @file_attachment, notice: 'File attachment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @file_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_attachments/1
  # DELETE /file_attachments/1.json
  def destroy
    @file_attachment = FileAttachment.find(params[:id])
    @file_attachment.destroy

    respond_to do |format|
      format.html { redirect_to file_attachments_url }
      format.json { head :no_content }
    end
  end
end
