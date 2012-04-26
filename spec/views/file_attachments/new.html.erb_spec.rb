require 'spec_helper'

describe "file_attachments/new" do
  before(:each) do
    assign(:file_attachment, stub_model(FileAttachment,
      :title => "MyString",
      :desc => "MyText"
    ).as_new_record)
  end

  it "renders new file_attachment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => file_attachments_path, :method => "post" do
      assert_select "input#file_attachment_title", :name => "file_attachment[title]"
      assert_select "textarea#file_attachment_desc", :name => "file_attachment[desc]"
    end
  end
end
