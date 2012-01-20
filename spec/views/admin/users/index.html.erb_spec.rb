require 'spec_helper'

describe "admin/users/index.html.erb" do
  before(:each) do
    assign(:users, [
      stub_model( User, :email => "user1@example.com" ),
      stub_model( User, :email => "user2@example.com" ),
    ])
  end

  it "should display a list of the current users" do
    render
    assert_select "ul>li>a", :count => 2
  end

  it "should have a link to add a new user" do
    render
    assert_select "a[href=/admin/users/new]", :text => "New User"
  end
end
