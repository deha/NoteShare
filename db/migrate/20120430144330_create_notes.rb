class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :folder
      t.integer :author_id
      t.string :title

      t.timestamps
    end
    
    add_index :notes, :author_id, :name => 'notes_author_id_ix'
    
    #TODD: enable index when folder is created
    add_index :notes, :folder_id, :name => 'notes_folder_id_ix'
  end
end
