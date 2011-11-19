class Project < ActiveRecord::Base
  has_many :tickets
  validates :name, :presence => true, 
                   :uniqueness => {:message => "must be unique"},
                   :length => {:maximum => 255}
end
