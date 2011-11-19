require 'spec_helper'

describe "projects/index.html.erb" do
  before(:each) do
    assign(:projects, [
      stub_model(Project,
        :name => "Name"
      ),
      stub_model(Project,
        :name => "Name"
      )
    ])
  end

  it "renders a list of projects" do
    render

    assert_select "ul>li>a", :text => "Name".to_s, :count => 2
  end
end
