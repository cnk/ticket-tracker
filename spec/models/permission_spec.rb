# == Schema Information
#
# Table name: permissions
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  thing_id   :integer
#  thing_type :string(255)
#  action     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Permission do
  it { should belong_to(:user) }
  it { should belong_to(:thing) }
  it { should validate_presence_of(:action) }
  it { should ensure_length_of(:action).is_at_most(255) }
end
