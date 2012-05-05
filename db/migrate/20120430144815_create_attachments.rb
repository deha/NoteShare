class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :note_id, :null => false
      t.string :title, :null => false
      t.text :description, :null => false
      t.integer :type

      t.timestamps
    end
    
    add_index :attachments, :note_id
  end
end
