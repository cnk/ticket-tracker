class Ticket < ActiveRecord::Base
  belongs_to :project
  validates :title, :presence => true, :length => {:maximum => 255}
  validates :description, :presence => true
end
