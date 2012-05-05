require 'spec_helper'

describe "permission_for_folders/index" do
  before(:each) do
    assign(:permission_for_folders, [
      stub_model(PermissionForFolder,
        :user => nil,
        :folder => nil
      ),
      stub_model(PermissionForFolder,
        :user => nil,
        :folder => nil
      )
    ])
  end

  it "renders a list of permission_for_folders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
