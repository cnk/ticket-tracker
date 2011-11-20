require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "Name"))
    @tickets = [assign(:ticket, stub_model(Ticket, :title => "Ticket title", :description => "Problem"))]
  end

  it "displays the project name" do
    render
    rendered.should match(/Name/)
  end

  it "displays an edit link" do
    render 
    assert_select "a", {:text => "Edit", :attributes => {:href => /\/projects\/\d\/edit/}}
  end

  it "displays a delete link" do
    render 
    assert_select "a[data-method=delete]", :text => "Delete"
  end

  it "displays the tickets for this project" do
    render 
    assert_select "ol>li>a[href]", :text => "Ticket title"
  end
end
