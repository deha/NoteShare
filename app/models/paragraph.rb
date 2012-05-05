class Paragraph < ActiveRecord::Base
  belongs_to :note
  has_one :prev, :foreign_key => "next_id", :class_name => "Paragraph"
  has_one :next, :foreign_key => "prev_id", :class_name => "Paragraph" 
  belongs_to :locking_user, :foreign_key => "locking_user_id", :class_name => "User"
end
