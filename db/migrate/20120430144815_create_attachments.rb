class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :note_id, :null => false
      t.string :title, :null => false
      t.text :description, :null => false
      t.integer :type

      t.string :attach_file_name
      t.string :attach_content_type
      t.integer :attach_file_size
      t.datetime :attach_updated_at   

      t.timestamps
    end
    
    add_index :attachments, :note_id
  end
end
