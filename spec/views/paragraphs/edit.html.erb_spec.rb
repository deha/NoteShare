require 'spec_helper'

describe "paragraphs/edit" do
  before(:each) do
    @paragraph = assign(:paragraph, stub_model(Paragraph,
      :note => nil,
      :prev => nil,
      :next => nil,
      :locking_user => nil,
      :text => "MyText"
    ))
  end

  it "renders the edit paragraph form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => paragraphs_path(@paragraph), :method => "post" do
      assert_select "input#paragraph_note", :name => "paragraph[note]"
      assert_select "input#paragraph_prev", :name => "paragraph[prev]"
      assert_select "input#paragraph_next", :name => "paragraph[next]"
      assert_select "input#paragraph_locking_user", :name => "paragraph[locking_user]"
      assert_select "textarea#paragraph_text", :name => "paragraph[text]"
    end
  end
end
