class Project < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => {:message => "must be unique"}
end
