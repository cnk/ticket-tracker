require 'spec_helper'

describe 'admin/users/new.html.erb' do
  before(:each) do
    assign(:user, stub_model(User).as_new_record)
  end
  
  it "renders the new user form" do
    render
    rendered.should have_selector("form", :action => admin_users_path(), :method => "post") 
  end

  it "has a field for email" do
    render
    rendered.should have_selector("input#user_email", :name => "user[email]")
  end

  it "has a password field" do
    render
    rendered.should have_selector("input#user_password", :name => "user[password]", :type => 'password')
  end

  it "has a password confirmation field" do
    render
    rendered.should have_selector("input#user_password_confirmation", :name => "user[password_confirmation]", :type => 'password')
  end

  it "has an unchecked checkbox for making someone an administrator" do
    render
    rendered.should have_unchecked_field("user_admin")
  end

end
