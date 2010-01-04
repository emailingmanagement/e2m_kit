require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  should_have_and_belong_to_many :roles
  
  [ :first_name, :last_name ].each do |a|
    should_validate_presence_of a
    should_not_allow_values_for a, '123', '1', '$*`', '******', '@lb4t0r'
    should_allow_values_for a, 'Jean-Marie', 'Laëtitia', 'Alphonse Brown'
  end

  # bug with factory girl on uniqueness
  context "uniqueness" do
    setup { Factory(:ben) }
    should_validate_uniqueness_of :email
  end
  
  should_not_allow_values_for :email, "blahh", "b lahh", :message => I18n.t('authlogic.error_messages.email_invalid')
  should_allow_values_for :email, "a@b.com", "asdf@asdf.com"
  
  should_not_allow_mass_assignment_of :crypted_password, :persistence_token, :perishable_token, :login_count, :failed_login_count, :last_request_at, :password_salt, :last_login_at, :current_login_at, :last_login_ip, :current_login_ip, :permalink
  
  should_allow_mass_assignment_of :email, :password, :password_confirmation, :first_name, :last_name
  
  should_have_db_index :persistence_token, :perishable_token
  should_have_db_index :email, :unique => true
  should_have_db_index :permalink, :unique => true

  context "User" do
    should("have an admin role") { assert Factory(:adminuser).admin? }
    should("have an agent role") { assert Factory(:agentuser).agent? }
  end
  
  context "A User instance" do
    setup do
      @user = Factory(:ben)
    end
    
    should "return its name" do
      assert_equal 'Ben Johnson', @user.name
    end
      
    should "have full name as param" do
      assert_equal @user.name.parameterize, @user.to_param
      assert_equal @user.name.parameterize, @user.permalink
    end    
  end
end