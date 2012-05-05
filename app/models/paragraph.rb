class Paragraph < ActiveRecord::Base
  belongs_to :note
  has_one :prev
  has_one :next
  belongs_to :locking_user
end
