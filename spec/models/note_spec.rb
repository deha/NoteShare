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

require 'spec_helper'

describe Note do
  pending "add some examples to (or delete) #{__FILE__}"
end
