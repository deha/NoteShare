class PermissionForNotesController < ApplicationController
  # GET /permission_for_notes
  # GET /permission_for_notes.json
  def index
    @permission_for_notes = PermissionForNote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permission_for_notes }
    end
  end

  # GET /permission_for_notes/1
  # GET /permission_for_notes/1.json
  def show
    @permission_for_note = PermissionForNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @permission_for_note }
    end
  end

  # GET /permission_for_notes/new
  # GET /permission_for_notes/new.json
  def new
    @permission_for_note = PermissionForNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permission_for_note }
    end
  end

  # GET /permission_for_notes/1/edit
  def edit
    @permission_for_note = PermissionForNote.find(params[:id])
  end

  # POST /permission_for_notes
  # POST /permission_for_notes.json
  def create
    @permission_for_note = PermissionForNote.new(params[:permission_for_note])
    
    puts(@permission_for_note.nil?)
    puts(params[:permission_for_note])

    respond_to do |format|
      if @permission_for_note.save
        format.html { redirect_to @permission_for_note, notice: 'Permission for note was successfully created.' }
        format.json { render json: @permission_for_note, status: :created, location: @permission_for_note }
      else
        format.html { render action: "new" }
        format.json { render json: @permission_for_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /permission_for_notes/1
  # PUT /permission_for_notes/1.json
  def update
    @permission_for_note = PermissionForNote.find(params[:id])

    respond_to do |format|
      if @permission_for_note.update_attributes(params[:permission_for_note])
        format.html { redirect_to @permission_for_note, notice: 'Permission for note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permission_for_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permission_for_notes/1
  # DELETE /permission_for_notes/1.json
  def destroy
    @permission_for_note = PermissionForNote.find(params[:id])
    @permission_for_note.destroy

    respond_to do |format|
      format.html { redirect_to permission_for_notes_url }
      format.json { head :no_content }
    end
  end
end
