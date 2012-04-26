require 'spec_helper'

describe "file_attachments/show" do
  before(:each) do
    @file_attachment = assign(:file_attachment, stub_model(FileAttachment,
      :title => "Title",
      :desc => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
