require 'spec_helper'

describe Ticket do
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(255) }

  it { should validate_presence_of(:description) }
  it { should belong_to(:project) }
end
