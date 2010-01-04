class CssPicture < ActiveRecord::Base
  belongs_to :kit

  has_attached_file :picture,
    :path => ":rails_root/public/att/kits/:kit_id/img/:basename.:extension",
    :url => "/att/kits/:kit_id/img/:basename.:extension"

  ##
  
  attr_accessible :kit, :picture

  ##

  validates_attachment_content_type :picture, 
   :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'],
   :message => I18n.t('parperclip.error_messages.content_type_invalid')

  validates_attachment_presence :picture, :message => I18n.t('paperclip.error_messages.validate_presence')
end