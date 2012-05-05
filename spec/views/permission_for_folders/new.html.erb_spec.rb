require 'spec_helper'

describe "permission_for_folders/new" do
  before(:each) do
    assign(:permission_for_folder, stub_model(PermissionForFolder,
      :user => nil,
      :folder => nil
    ).as_new_record)
  end

  it "renders new permission_for_folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => permission_for_folders_path, :method => "post" do
      assert_select "input#permission_for_folder_user", :name => "permission_for_folder[user]"
      assert_select "input#permission_for_folder_folder", :name => "permission_for_folder[folder]"
    end
  end
end
