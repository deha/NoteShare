require 'spec_helper'

describe "attachments/edit" do
  before(:each) do
    @attachment = assign(:attachment, stub_model(Attachment,
      :note_id => 1,
      :title => "MyText",
      :description => "MyText",
      :type => 1
    ))
  end

  it "renders the edit attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => attachments_path(@attachment), :method => "post" do
      assert_select "input#attachment_note_id", :name => "attachment[note_id]"
      assert_select "textarea#attachment_title", :name => "attachment[title]"
      assert_select "textarea#attachment_description", :name => "attachment[description]"
      assert_select "input#attachment_type", :name => "attachment[type]"
    end
  end
end
