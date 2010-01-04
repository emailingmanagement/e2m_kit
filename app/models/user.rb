require 'acts_as_permalink'

class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
    c.logged_in_timeout = 10.minutes
  end
  acts_as_permalink
  
  ##
  
  has_and_belongs_to_many :roles
  
  ##
  
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  ##
  
  RE_NAME_FORMAT = /^[a-zA-Z'àâäãéèêëôõöùûüçîïÀÂÄÃÉÈÊËÕÔÖÙÛÜÇÎÏ\.\s-]{2,40}$/
  [ :first_name, :last_name ].each do |a| 
    validates_presence_of a
    validates_format_of a, :allow_nil => false, :with => RE_NAME_FORMAT
  end
  
  ##
  
  def name
    "#{first_name} #{last_name}"
  end
  alias_method :used_to_make_permalink, :name
  
  ## roles
  
  %w(admin agent).each do |r|
    define_method("#{r}?") { roles.map{ |ro| ro.title }.include?(r) }
  end
end