require File.dirname(__FILE__) + '/../test_helper'

class ContactTest < ActiveSupport::TestCase
  should_belong_to :subscription
  should_belong_to :kit

  should_allow_mass_assignment_of :subscription, :email, :source, :name, :invited, :kit
  should_validate_presence_of :subscription, :email, :source, :kit

  should_not_allow_values_for :email, "blahh", "b lahh", :message => I18n.t('activerecord.errors.messages')[:email_invalid]
  should_allow_values_for :email, "a@b.com", "asdf@asdf.com"

  should_have_db_index :subscription_id
  should_have_db_index :kit_id
  
  
  context "uniqueness" do
    setup do
      @kit = Factory(:kit)
      @subscription = Factory(:subscription, :kit => @kit)
      @contact = Factory(:contact, :subscription => @subscription, :kit => @kit)
    end
    should_validate_uniqueness_of :email, :scoped_to => :kit_id, :case_sensitive => false
  end  
  
  context "invites" do
    setup do
      @kit = Factory(:kit)
      @subscription = Factory(:subscription, :kit => @kit)
      @contact = Factory(:contact, :subscription => @subscription, :kit => @kit, :invited => false)
      @contact2 = Factory(:contact, :subscription => @subscription, :kit => @kit, :invited => true, :email => 'jojolaplume@email.fr')
    end
    
    should "be sent" do
      assert !@contact.invite_sent
      assert !@contact2.invite_sent
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        Contact.deliver_invites
      end
      assert !@contact.reload.invite_sent
      assert @contact2.reload.invite_sent
    end
  end
  
  context "already subscribed" do
    setup do
      @kit = Factory(:kit)
      @subscription = Factory(:subscription, :kit => @kit)
    end
    
    should "not be created" do
      assert_raise(ActiveRecord::RecordInvalid) do
        Factory(:contact, :subscription => @subscription, :kit => @kit, :email => @subscription.email)
      end
    end
  end
  
end
