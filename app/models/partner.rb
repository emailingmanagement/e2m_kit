class Partner < ActiveRecord::Base
  belongs_to :user
  belongs_to :kit
  has_many :partner_subscriptions
  has_many :subscriptions, :through => :partner_subscriptions

  has_attached_file :picture,
    :path => ":rails_root/public/att/partners/:id/:basename.:extension",
    :url => "/att/partners/:id/:basename.:extension"
  
  ##
  
  attr_accessible :name, :title, :extra_field_name, :description, :picture, :user, :kit

  ##
  
  validates_presence_of :name, :title, :description, :user, :kit
  
  validates_attachment_presence :picture, :message => I18n.t('paperclip.error_messages.validate_presence')
end
