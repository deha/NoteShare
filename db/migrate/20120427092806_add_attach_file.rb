class AddAttachFile < ActiveRecord::Migration
  def up
    add_column :file_attachments, :attach_file_name,    :string
    add_column :file_attachments, :attach_content_type, :string
    add_column :file_attachments, :attach_file_size,    :integer
    add_column :file_attachments, :attach_updated_at,   :datetime
  end

  def down
    remove_column :file_attachments, :attach_file_name
    remove_column :file_attachments, :attach_content_type
    remove_column :file_attachments, :attach_file_size
    remove_column :file_attachments, :attach_updated_at
  end
end
