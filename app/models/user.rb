# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  has_many :permission_for_notes, :dependent => :destroy
  has_many :notes, :through => :permission_for_notes
  has_many :permission_for_folders, :dependent => :destroy
  has_many :folders, :through => :permission_for_folders
end
