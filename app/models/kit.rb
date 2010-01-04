class Kit < ActiveRecord::Base
  acts_as_permalink
  
  ##
  
  belongs_to :user
  has_many :partners, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy
  has_many :css_pictures, :order => :picture_updated_at, :dependent => :destroy
  has_many :contacts
  has_many :sources, :dependent => :destroy

  has_attached_file :css,
    :path => ":rails_root/public/att/kits/:id/:basename.:extension",
    :url => "/att/kits/:id/:basename.:extension"
  
  has_attached_file :email1_picture,
    :path => ":rails_root/public/att/kits/:id/emails/:basename.:extension",
    :url => "/att/kits/:id/emails/:basename.:extension"

  has_attached_file :email2_picture,
    :path => ":rails_root/public/att/kits/:id/emails/:basename.:extension",
    :url => "/att/kits/:id/emails/:basename.:extension"
  
  ##
  
  attr_accessible :lang, :title, :name, :user, :finished_at, :css, :rules, :default_country, :email1_picture, :email2_picture, :email_bg_color, :email_links_color
  
  ##
  
  validates_presence_of :lang, :title, :name, :user, :finished_at, :default_country

  validates_label_key :lang, :i18n_keys => 'activerecord.attributes.kit.lang_list'


  validates_attachment_content_type :email1_picture, 
   :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'],
   :message => I18n.t('parperclip.error_messages.content_type_invalid')


  validates_attachment_content_type :email2_picture, 
   :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'],
   :message => I18n.t('parperclip.error_messages.content_type_invalid')

#  validates_attachment_presence :css, :message => I18n.t('paperclip.error_messages.validate_presence')
#  validates_attachment_presence :email1_picture, :message => I18n.t('paperclip.error_messages.validate_presence')
#  validates_attachment_presence :email2_picture, :message => I18n.t('paperclip.error_messages.validate_presence')

  ##
  
  def used_to_make_permalink
    name
  end
  
  def invites_rate
    c_count = contacts.count(:conditions => { :invite_sent => true })
    return 0 if c_count == 0
    subscriptions.count(:conditions => "parent_id IS NOT NULL").to_f / c_count.to_f
  end
  
  def invites_domains
    contacts.all(:select => :email, :conditions => { :invite_sent => true }).inject({}) do |h, c|
      d = c.email.split('@').last
      h[d] = (h[d] ? h[d] + 1 : 1)
      h
    end
  end
  
  def subscriptions_countries
    subscriptions.all(:select => :country).inject({}) do |h, s|
      c = s.country
      h[c] = (h[c] ? h[c] + 1 : 1)
      h
    end
  end

  def partners_subscriptions
    partners.inject({}) do |h, p|
      h[p] = p.partner_subscriptions.count
      h
    end
  end
  
  def sources_subscriptions
    sources.inject({}) do |h, s|
      h[s] = s.subscriptions.count
      h
    end
  end
end