class Subscription < ActiveRecord::Base
  belongs_to :kit
  belongs_to :parent, :foreign_key => 'parent_id', :class_name => 'Subscription'
  belongs_to :source
  has_many :contacts, :dependent => :destroy

  ##
  
  attr_accessible :email, :civility, :first_name, :last_name, :region, :city, :country, :occupation, :date_of_birth, :kit, :parent, :source
  
  ##
  
  validates_presence_of :email, :civility, :first_name, :last_name, :region, :city, :country, :occupation, :date_of_birth, :kit

  validates_email :email
  validates_uniqueness_of :email, :scope => :kit_id, :case_sensitive => false, 
    :message => I18n.t('activerecord.errors.subscription.taken')
  validates_label_key :civility, :i18n_keys => 'activerecord.attributes.subscription.civility_list'
  validates_label_key :occupation, :i18n_keys => 'activerecord.attributes.subscription.occupation_list'
  
  ##
  
  def name
    "#{first_name} #{last_name}"
  end
end
