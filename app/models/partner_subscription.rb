class PartnerSubscription < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :partner
  
  ##
  
  attr_accessible :subscription, :partner, :extra_field_value
  
  ##
  
  validates_presence_of :subscription, :partner
  validates_presence_of :extra_field_value, :if => Proc.new { |ps| ps.partner && !ps.partner.extra_field_name.blank? }
  validates_uniqueness_of :partner_id, :scope => :subscription_id
end