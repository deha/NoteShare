require 'spec_helper'

describe "permission_for_notes/new" do
  before(:each) do
    assign(:permission_for_note, stub_model(PermissionForNote,
      :level => 1,
      :user_id => 1,
      :note_id => 1
    ).as_new_record)
  end

  it "renders new permission_for_note form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => permission_for_notes_path, :method => "post" do
      assert_select "input#permission_for_note_level", :name => "permission_for_note[level]"
      assert_select "input#permission_for_note_user_id", :name => "permission_for_note[user_id]"
      assert_select "input#permission_for_note_note_id", :name => "permission_for_note[note_id]"
    end
  end
end
