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

require 'spec_helper'

describe Attachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
