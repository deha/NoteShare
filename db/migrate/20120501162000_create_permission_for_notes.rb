class CreatePermissionForNotes < ActiveRecord::Migration
  def change
    create_table(:permission_for_notes, :id => false) do |t|
      t.string :level
      t.references :user
      t.references :note

      t.timestamps
    end
    
    add_index :permission_for_notes, :note_id, :name => 'permission_for_notes_note_id_ix'
    add_index :permission_for_notes, :user_id, :name => 'permission_for_notes_user_id_ix'
    add_index :permission_for_notes, [:note_id, :user_id], unique: true
  end
end
