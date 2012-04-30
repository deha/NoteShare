class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :note_id
      t.text :title
      t.text :description
      t.integer :type

      t.timestamps
    end
  end
end
