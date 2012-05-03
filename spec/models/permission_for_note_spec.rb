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

require 'spec_helper'

describe PermissionForNote do
  pending "add some examples to (or delete) #{__FILE__}"
end
