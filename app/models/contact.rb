class Contact < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :kit
  
  ##
  
  attr_accessible :subscription, :email, :source, :name, :invited, :kit
  
  ##
  
  validates_presence_of :subscription, :email, :source, :kit, :name
  validates_email :email
  validates_uniqueness_of :email, :scope => :kit_id, :case_sensitive => false
  before_validation { |c| c.name = c.email if c.name.blank? }
  before_validation_on_create { |c| c.kit = c.subscription.kit if c.subscription }
  
  def validate
    return unless email
    errors.add(:email, "already subscribed") if Subscription.find_by_email(email)
  end
  
  
  def self.deliver_invites
    all(:conditions => "invited = 1 AND invite_sent = 0").each do |c|
      begin
        ApplicationNotifier.deliver_invite(c)
      rescue Net::SMTPFatalError => error
        Rails.logger.error "error sending invited to #{c.email}"
      end
      c.update_attribute(:invite_sent, true)
    end
  end
end
