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

  # Shoulda's uniqueness matcher needs us to have already created at least one project
  subject { FactoryGirl.create(:project) }
  it { should validate_uniqueness_of(:name).with_message(/must be unique/) }

  it {should have_many(:tickets).dependent(:destroy) }
  it {should have_many(:permissions).dependent(:destroy) }
end
