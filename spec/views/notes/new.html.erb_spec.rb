require 'spec_helper'

describe "notes/new" do
  before(:each) do
    assign(:note, stub_model(Note,
      :folder_id => "MyString",
      :author_id => 1,
      :title => "MyText"
    ).as_new_record)
  end

  it "renders new note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notes_path, :method => "post" do
      assert_select "input#note_folder_id", :name => "note[folder_id]"
      assert_select "input#note_author_id", :name => "note[author_id]"
      assert_select "textarea#note_title", :name => "note[title]"
    end
  end
end
