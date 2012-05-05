class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :folder
      t.integer :author_id
      t.string :title

      t.timestamps
    end
    
    add_index :notes, :author_id
    add_index :notes, :folder_id
  end
end
