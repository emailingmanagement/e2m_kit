require File.dirname(__FILE__) + '/../test_helper'

class PartnerSubscriptionsControllerTest < ActionController::TestCase
  def setup
    @kit = Factory(:kit)
    @subscription = Factory(:subscription, :kit => @kit)
    @partner = Factory(:partner, :kit => @kit, :extra_field_name => 'pouic', :user => @kit.user)
    @partner2 = Factory(:partner, :kit => @kit, :name => 'partner 2', :extra_field_name => nil, :user => @kit.user)
  end
  
  context "on POST to :create" do
    should "add 2 new subscriptions" do
      session[:subscription_id] = @subscription.id
      assert_difference "PartnerSubscription.count", 2 do
        xhr :post, :create, :kit_id => @kit.permalink, 
          "partner_#{@partner.id}_choice" => '1', "partner_#{@partner2.id}_choice" => '1', "partner_#{@partner.id}_extra" => 'banco'
      end
      assert_equal 3, session[:step]
    end

    should "add 1 new subscriptions" do
      session[:subscription_id] = @subscription.id
      assert_difference "PartnerSubscription.count", 1 do
        xhr :post, :create, :kit_id => @kit.permalink, 
          "partner_#{@partner.id}_choice" => '1', "partner_#{@partner2.id}_choice" => '0', "partner_#{@partner.id}_extra" => 'banco'
      end
      assert_equal 3, session[:step]
    end
    
    should "not add new subscriptions (missing extra value)" do
      session[:subscription_id] = @subscription.id
      assert_no_difference "PartnerSubscription.count" do
        xhr :post, :create, :kit_id => @kit.permalink, 
          "partner_#{@partner.id}_choice" => '1', "partner_#{@partner2.id}_choice" => '0', "partner_#{@partner.id}_extra" => nil
      end
      assert_template 'partner'
    end

    should "not add new subscriptions (checkboxes not checked)" do
      session[:subscription_id] = @subscription.id
      assert_no_difference "PartnerSubscription.count" do
        xhr :post, :create, :kit_id => @kit.permalink, 
          "partner_#{@partner.id}_choice" => nil, "partner_#{@partner2.id}_choice" => nil, "partner_#{@partner.id}_extra" => nil
      end
      assert_template 'flash_message'
    end
    
    should "not add new subscriptions (1 checkbox not checked and missing extra value)" do
      session[:subscription_id] = @subscription.id
      assert_no_difference "PartnerSubscription.count" do
        xhr :post, :create, :kit_id => @kit.permalink, 
          "partner_#{@partner.id}_choice" => '1', "partner_#{@partner2.id}_choice" => nil, "partner_#{@partner.id}_extra" => nil
      end
      assert_template 'partner'
    end
  end  
end