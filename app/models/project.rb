# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  has_many :tickets
  attr_accessible :name
  validates :name, :presence => true, 
                   :uniqueness => {:message => "must be unique"},
                   :length => {:maximum => 255}
end
