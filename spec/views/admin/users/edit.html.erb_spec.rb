require 'spec_helper'

describe 'admin/users/edit.html.erb' do
  before(:each) do
    @admin = FactoryGirl.create(:admin) 
    assign(:user, @admin)
  end

  # Don't bother to repeat field tests we did in new.html.erb_spec.rb
  # Just check the two prefills that matter

  it "should populate the email field with the current email address" do
    render
    rendered.should have_selector("input#user_email", :name => "user[email]", :value => @admin.email)
  end

  it "should check the admin checkbox if the user is already an admin" do 
    render
    rendered.should have_checked_field("user_admin")
  end

end
