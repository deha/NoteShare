class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.references :note
      t.references :prev
      t.references :next
      t.references :locking_user
      t.text :text
      t.datetime :lock_time

      t.timestamps
    end
    
    add_index :paragraphs, :note_id
    add_index :paragraphs, :prev_id
    add_index :paragraphs, :next_id
    add_index :paragraphs, :locking_user_id
  end
end
