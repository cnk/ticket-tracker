class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :title, :presence => true, :length => {:maximum => 255}
  validates :description, :presence => true
end
