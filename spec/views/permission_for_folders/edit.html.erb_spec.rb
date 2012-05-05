require 'spec_helper'

describe "permission_for_folders/edit" do
  before(:each) do
    @permission_for_folder = assign(:permission_for_folder, stub_model(PermissionForFolder,
      :user => nil,
      :folder => nil
    ))
  end

  it "renders the edit permission_for_folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => permission_for_folders_path(@permission_for_folder), :method => "post" do
      assert_select "input#permission_for_folder_user", :name => "permission_for_folder[user]"
      assert_select "input#permission_for_folder_folder", :name => "permission_for_folder[folder]"
    end
  end
end
