class PermissionForFoldersController < ApplicationController
  # GET /permission_for_folders
  # GET /permission_for_folders.json
  def index
    @permission_for_folders = PermissionForFolder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permission_for_folders }
    end
  end

  # GET /permission_for_folders/1
  # GET /permission_for_folders/1.json
  def show
    @permission_for_folder = PermissionForFolder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @permission_for_folder }
    end
  end

  # GET /permission_for_folders/new
  # GET /permission_for_folders/new.json
  def new
    @permission_for_folder = PermissionForFolder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permission_for_folder }
    end
  end

  # GET /permission_for_folders/1/edit
  def edit
    @permission_for_folder = PermissionForFolder.find(params[:id])
  end

  # POST /permission_for_folders
  # POST /permission_for_folders.json
  def create
    @permission_for_folder = PermissionForFolder.new(params[:permission_for_folder])

    respond_to do |format|
      if @permission_for_folder.save
        format.html { redirect_to @permission_for_folder, notice: 'Permission for folder was successfully created.' }
        format.json { render json: @permission_for_folder, status: :created, location: @permission_for_folder }
      else
        format.html { render action: "new" }
        format.json { render json: @permission_for_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /permission_for_folders/1
  # PUT /permission_for_folders/1.json
  def update
    @permission_for_folder = PermissionForFolder.find(params[:id])

    respond_to do |format|
      if @permission_for_folder.update_attributes(params[:permission_for_folder])
        format.html { redirect_to @permission_for_folder, notice: 'Permission for folder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @permission_for_folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permission_for_folders/1
  # DELETE /permission_for_folders/1.json
  def destroy
    @permission_for_folder = PermissionForFolder.find(params[:id])
    @permission_for_folder.destroy

    respond_to do |format|
      format.html { redirect_to permission_for_folders_url }
      format.json { head :no_content }
    end
  end
end
