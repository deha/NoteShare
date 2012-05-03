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
  
  ADMIN_RIGHT = "administrator notatki"
  WRITE_RIGHT = "modyfikowanie notatki"
  
  ALL_RIGHTS = [ADMIN_RIGHT, WRITE_RIGHT]
  
  attr_accessible :level, :user_id
  
  validates_inclusion_of :level, :in => ALL_RIGHTS
end
