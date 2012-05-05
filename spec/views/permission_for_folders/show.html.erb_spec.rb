require 'spec_helper'

describe "permission_for_folders/show" do
  before(:each) do
    @permission_for_folder = assign(:permission_for_folder, stub_model(PermissionForFolder,
      :user => nil,
      :folder => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
