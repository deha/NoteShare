# == Schema Information
#
# Table name: permission_for_notes
#
#  id         :integer         not null, primary key
#  level      :integer
#  user_id    :integer
#  note_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class PermissionForNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :note
  
  ADMIN_LEVEL = "administrator notatki"
  WRITE_LEVEL = "modyfikowanie notatki"
  
  ALL_LEVELS = [ADMIN_LEVEL, WRITE_LEVEL]
  
  attr_accessible :level, :user_id
  
  validates_inclusion_of :level, :in => ALL_LEVELS
end
