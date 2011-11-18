require 'spec_helper'

describe Project do
  it "should require a name attribute" do
    project = Project.create
    project.should_not be_valid
    project.errors.full_messages.should include("Name can't be blank")
  end

  it "should require the name to be unique" do
    project1 = Project.create!(:name => "Cool Project")
    project1.should be_valid
    project2 = Project.new(:name => "Cool Project")
    project2.save.should be_false
    project2.should_not be_valid
    project2.errors.full_messages.should include("Name must be unique")
  end
end
