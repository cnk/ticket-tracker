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
  attr_accessible :name
  validates :name, :presence => true, 
                   :uniqueness => {:message => "must be unique"},
                   :length => {:maximum => 255}

  has_many :tickets
  has_many :permissions, :as => :thing

  scope :readable_by, lambda{ |user| joins(:permissions).where(:permissions => { :action => 'view',
                                                                                 :user_id => user.id })}
end
