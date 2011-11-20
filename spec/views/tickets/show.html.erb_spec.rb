require 'spec_helper'

describe "tickets/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "My Project"))
    @ticket = assign(:ticket, stub_model(Ticket, :title => "Ticket title", :description => "Problem"))
  end

  it "displays the project name" do
    render
    rendered.should match(/My Project/)
  end

  it "displays the ticket title" do
    render
    rendered.should match(/Ticket title/)
  end

  it "displays an edit link" do
    render 
    assert_select "a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/tickets\/\d\/edit/}}
  end

  it "displays a link to create a new ticket" do
    render 
    assert_select "a", {:text => "New Ticket", :attributes => {:href => /\/projects\/\d\/tickets\/new/}}
  end

  it "displays a link to the ticket's project" do
    render 
    assert_select "a", {:text => "My Project", :attributes => {:href => /\/projects\/\d/}}
  end

  it "displays a link to all projects" do
    render 
    assert_select "a", {:text => "All Projects", :attributes => {:href => /\/projects/}}
  end

  it "displays a delete link" do
    render 
    assert_select "a[data-method=delete]", :text => "Delete"
  end

end
