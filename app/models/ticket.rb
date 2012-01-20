# == Schema Information
#
# Table name: tickets
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  project_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :title, :description

  validates :title, :presence => true, :length => {:maximum => 255}
  validates :description, :presence => true
end
