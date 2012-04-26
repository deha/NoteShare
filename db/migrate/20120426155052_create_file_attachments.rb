class CreateFileAttachments < ActiveRecord::Migration
  def change
    create_table :file_attachments do |t|
      t.string :title
      t.text :desc
      t.references :note
      t.timestamps
    end
  end
end
