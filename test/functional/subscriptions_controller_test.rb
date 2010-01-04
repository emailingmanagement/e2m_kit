require File.dirname(__FILE__) + '/../test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def setup
    @kit = Factory(:kit)
  end
  
  context "on POST to :create" do
    should "add a new subscription"  do
      assert_difference "Subscription.count" do
        xhr :post, :create, :kit_id => @kit.permalink, :subscription => {
          :email => 'bingo@email.fr', :civility => '03_mister', :first_name => 'Bing', :last_name => 'Bingo',
          :region => 'Pays de la Loire', :city => 'Nantes', :country => 'FRA', :occupation => '01_students', 
          :date_of_birth => 20.years.ago
        }, :its_so_sweet => { :email => 'john@doe.com', :name => '', :agree => nil } 
      end
      assert_response :success
      assert_template 'steps'
      assert_equal 2, session[:step]
    end
    
    should "not add a new subscription" do
      assert_no_difference "Subscription.count" do
        xhr :post, :create, :kit_id => @kit.permalink, :subscription => {
          :email => 'bingo', :civility => '03_mister', :first_name => 'Bing', :last_name => 'Bingo',
          :region => 'Pays de la Loire', :city => 'Nantes', :country => 'FRA', :occupation => '01_students', 
          :date_of_birth => 20.years.ago
        }, :its_so_sweet => { :email => 'john@doe.com', :name => '', :agree => nil } 
      end
      assert_template 'new'
    end
  end
  
  context "on GET to :select_region_and_city" do
    should "show" do
      xhr :get, :select_region_and_city, :kit_id => @kit.permalink, :country_code => 'FR'
      assert_template 'select_region_and_city'
    end
  end
  
end