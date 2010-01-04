require File.dirname(__FILE__) + '/../test_helper'

class PartnerSubscriptionTest < ActiveSupport::TestCase
 should_belong_to :subscription
 should_belong_to :partner
 should_allow_mass_assignment_of :subscription, :partner, :extra_field_value
 should_validate_presence_of :subscription, :partner
 should_have_db_index :subscription_id, :partner_id
 
 context "extra field" do
   setup do
     @kit = Factory(:kit)
     @sub = Factory(:subscription, :kit => @kit)
   end
   
   should "be required" do
     partner = Factory(:partner, :kit => @kit, :extra_field_name => 'pouic', :user => @kit.user)
     ps = PartnerSubscription.new(:subscription => @sub, :partner => partner, :extra_field_value => nil)
     assert !ps.valid?
     ps.extra_field_value = 'yeah'
     assert ps.valid?
   end
   
 end
 
end