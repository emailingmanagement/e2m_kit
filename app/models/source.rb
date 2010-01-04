class Source < ActiveRecord::Base
  belongs_to :kit
  has_many :subscriptions
  
  ##
  
  attr_accessible :kit, :name

  ##

  validates_presence_of :kit, :name
end
