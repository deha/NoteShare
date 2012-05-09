# == Schema Information
#
# Table name: attachments
#
#  id          :integer         not null, primary key
#  note_id     :integer
#  title       :string(255)
#  description :text
#  type        :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Attachment < ActiveRecord::Base
  belongs_to :note
  has_attached_file :attach
  
  attr_accessible :type, :note_id, :title, :description, :attach
end
