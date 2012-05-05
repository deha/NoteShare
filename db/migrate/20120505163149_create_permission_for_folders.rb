class CreatePermissionForFolders < ActiveRecord::Migration
  def change
    create_table :permission_for_folders do |t|
      t.references :user
      t.references :folder

      t.timestamps
    end
    add_index :permission_for_folders, :user_id
    add_index :permission_for_folders, :folder_id
    add_index :permission_for_folders, [:user_id, :folder_id], unique: true
  end
end
