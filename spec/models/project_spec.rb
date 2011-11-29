# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Project do
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_most(255) }

  it "should require the name to be unique" do
    project1 = Project.create!(:name => "Cool Project")
    project1.should be_valid
    # now try to create another project
    project2 = Project.new(:name => "Cool Project")
    project2.save.should be_false
    project2.should_not be_valid
    project2.errors.full_messages.should include("Name must be unique")
  end
end
