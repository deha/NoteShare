require 'spec_helper'

describe "permission_for_notes/show" do
  before(:each) do
    @permission_for_note = assign(:permission_for_note, stub_model(PermissionForNote,
      :level => 1,
      :user_id => 1,
      :note_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
