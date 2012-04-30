require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :first_name => "MyText",
        :last_name_text => "Last Name Text"
      ),
      stub_model(User,
        :first_name => "MyText",
        :last_name_text => "Last Name Text"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last Name Text".to_s, :count => 2
  end
end
