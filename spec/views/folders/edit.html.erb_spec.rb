require 'spec_helper'

describe "folders/edit" do
  before(:each) do
    @folder = assign(:folder, stub_model(Folder,
      :parent_id => 1,
      :name => "MyString",
      :description => "MyText",
      :level => "MyString"
    ))
  end

  it "renders the edit folder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => folders_path(@folder), :method => "post" do
      assert_select "input#folder_parent_id", :name => "folder[parent_id]"
      assert_select "input#folder_name", :name => "folder[name]"
      assert_select "textarea#folder_description", :name => "folder[description]"
      assert_select "input#folder_level", :name => "folder[level]"
    end
  end
end
