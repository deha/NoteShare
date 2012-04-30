require 'spec_helper'

describe "users/new" do
  before(:each) do
    assign(:user, stub_model(User,
      :first_name => "MyText",
      :last_name_text => "MyString"
    ).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path, :method => "post" do
      assert_select "textarea#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name_text", :name => "user[last_name_text]"
    end
  end
end
