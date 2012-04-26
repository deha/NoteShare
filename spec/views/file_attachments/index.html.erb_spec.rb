require 'spec_helper'

describe "file_attachments/index" do
  before(:each) do
    assign(:file_attachments, [
      stub_model(FileAttachment,
        :title => "Title",
        :desc => "MyText"
      ),
      stub_model(FileAttachment,
        :title => "Title",
        :desc => "MyText"
      )
    ])
  end

  it "renders a list of file_attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
