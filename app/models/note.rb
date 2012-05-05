# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  folder_id  :integer
#  author_id  :integer
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Note < ActiveRecord::Base
  has_many :permission_for_notes
  has_many :users, :through => :permission_for_notes
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  
  accepts_nested_attributes_for :permission_for_notes, :allow_destroy => true
end
