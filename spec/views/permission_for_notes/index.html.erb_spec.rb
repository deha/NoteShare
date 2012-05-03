require 'spec_helper'

describe "permission_for_notes/index" do
  before(:each) do
    assign(:permission_for_notes, [
      stub_model(PermissionForNote,
        :level => 1,
        :user_id => 1,
        :note_id => 1
      ),
      stub_model(PermissionForNote,
        :level => 1,
        :user_id => 1,
        :note_id => 1
      )
    ])
  end

  it "renders a list of permission_for_notes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
