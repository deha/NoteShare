require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :first_name => "MyText",
      :last_name_text => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "textarea#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name_text", :name => "user[last_name_text]"
    end
  end
end
