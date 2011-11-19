require 'spec_helper'

describe "projects/show.html.erb" do
  before(:each) do
    @project = assign(:project, stub_model(Project,
      :name => "Name"
    ))
  end

  it "displays the project name" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
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
end
