require 'spec_helper'

describe "folders/new" do
  before(:each) do
    assign(:folder, stub_model(Folder,
      :parent_id => 1,
      :name => "MyString",
      :description => "MyText",
      :level => "MyString"
    ).as_new_record)
  end

  it "renders new folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => folders_path, :method => "post" do
      assert_select "input#folder_parent_id", :name => "folder[parent_id]"
      assert_select "input#folder_name", :name => "folder[name]"
      assert_select "textarea#folder_description", :name => "folder[description]"
      assert_select "input#folder_level", :name => "folder[level]"
    end
  end
end
