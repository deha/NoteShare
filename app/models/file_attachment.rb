class FileAttachment < ActiveRecord::Base
  belongs_to :note
  has_attached_file :attach
end
