class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :thing, :polymorphic => true

  validates_presence_of :action
  validates_length_of :action, :maximum => 255
end
