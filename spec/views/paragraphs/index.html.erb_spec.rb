require 'spec_helper'

describe "paragraphs/index" do
  before(:each) do
    assign(:paragraphs, [
      stub_model(Paragraph,
        :note => nil,
        :prev => nil,
        :next => nil,
        :locking_user => nil,
        :text => "MyText"
      ),
      stub_model(Paragraph,
        :note => nil,
        :prev => nil,
        :next => nil,
        :locking_user => nil,
        :text => "MyText"
      )
    ])
  end

  it "renders a list of paragraphs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
