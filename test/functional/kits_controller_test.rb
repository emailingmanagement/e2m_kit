require File.dirname(__FILE__) + '/../test_helper'

class KitsControllerTest < ActionController::TestCase
  def setup
    @kit = Factory(:kit)
  end
  
  context "on GET to :show" do
    should "display kit" do
      parent = Factory(:subscription, :kit => @kit)
      get :show, :id => @kit.permalink, :email => 'jojo@email.fr', :parent => parent.id
      assert_response :success
      assert_template 'show'
      assert_equal @kit, assigns(:kit)
      assert (s = assigns(:subscription)).new_record?
      assert_equal @kit.default_country, s.country
      assert_equal 'jojo@email.fr', s.email
      assert_equal session[:parent], parent.id.to_s
    end
    
    should "display kit with loading subscription" do
      subscription = Factory(:subscription, :kit => @kit)
      session[:subscription_id] = subscription
      get :show, :id => @kit.permalink
      assert_response :success
      assert_template 'show'
      assert_equal @kit, assigns(:kit)
      assert subscription, assigns(:subscription)
    end
    
    should "display first kit if id is invalid" do
      get :show, :id => 212121
      assert_response :success
      assert_template 'show'
      assert_equal @kit, assigns(:kit)
    end

    should "display first kit if no id given" do
      get :show
      assert_response :success
      assert_template 'show'
      assert_equal @kit, assigns(:kit)
    end
  end


  context "on GET to :rules" do
    should "show rules" do
      get :rules, :email => 1
      assert_response :success
      assert_template 'rules'
      assert assigns(:email)
    end
  end
  
end
