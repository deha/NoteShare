class PermissionForFoldersController < ApplicationController

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
