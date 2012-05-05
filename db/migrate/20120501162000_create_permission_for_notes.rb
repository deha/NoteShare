class CreatePermissionForNotes < ActiveRecord::Migration
  def change
    create_table :permission_for_notes do |t|
      t.string :level
      t.references :user
      t.references :note

      t.timestamps
    end
    
    add_index :permission_for_notes, :note_id
    add_index :permission_for_notes, :user_id
    add_index :permission_for_notes, [:note_id, :user_id], unique: true
  end
end
