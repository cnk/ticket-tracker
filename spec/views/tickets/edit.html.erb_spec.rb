require 'spec_helper'

describe "tickets/edit.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "MyString"
    ))
    @ticket = assign(:ticket, stub_model(Ticket, :title => "Ticket title", :description => "Problem"))
  end

  it "renders the edit project form" do
    render

    assert_select "form", :action => edit_project_ticket_path(@project, @ticket), :method => "post" do
      assert_select "input#ticket_title", :name => "ticket[title]"
      assert_select "textarea#ticket_description", :name => "ticket[description]"
    end
  end
end
