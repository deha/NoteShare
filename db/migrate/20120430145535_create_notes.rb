class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :folder_id
      t.integer :author_id
      t.text :title

      t.timestamps
    end
  end
end
