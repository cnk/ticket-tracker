require 'spec_helper'

describe "tickets/new.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project, :name => "MyString"))
    assign(:ticket, 
           stub_model(Ticket, :title => "Ticket title", :description => "Problem").as_new_record)
  end

  it "renders new ticket form" do
    render

    assert_select "form", :action => new_project_ticket_path(@project), :method => "put" do
      assert_select "input#ticket_title", :name => "ticket[title]"
      assert_select "textarea#ticket_description", :name => "ticket[description]"
    end
  end
end
