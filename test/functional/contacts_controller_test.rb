require File.dirname(__FILE__) + '/../test_helper'

class ContactsControllerTest < ActionController::TestCase
  def setup
    @kit = Factory(:kit)
    @subscription = Factory(:subscription, :kit => @kit)
  end
  
  context "on :POST to create (emails)" do
    should "create 4 contacts" do
      session[:step] = 3
      session[:subscription_id] = @subscription.id
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        assert_difference "Contact.count", 4 do
          xhr :post, :create, :kit_id => @kit.permalink,
            :email_1 => 'jojo@email.fr', :email_2 => 'jiji@email.fr', :email_3 => 'bingo@joun.fr', :email_4 => 'pouic@am.fr'
        end
      end
      assert_nil session[:step]
      assert_nil session[:subscription_id]
    end

    should "not create contact which is already subscribed" do
      sub = Factory(:subscription, :kit => @kit, :email => "bingo@meail.fr")
      session[:step] = 3
      session[:subscription_id] = @subscription.id
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        assert_no_difference "Contact.count" do
          xhr :post, :create, :kit_id => @kit.permalink, :email_1 => sub.email
        end
      end
      assert_nil session[:step]
      assert_nil session[:subscription_id]
    end

    should "not create duplicated contacts" do
      session[:step] = 3
      session[:subscription_id] = @subscription.id
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        assert_difference "Contact.count", 3 do
          xhr :post, :create, :kit_id => @kit.permalink,
            :email_1 => 'jojo@email.fr', :email_2 => 'jojo@email.fr', :email_3 => 'bingo@joun.fr', :email_4 => 'pouic@am.fr'
        end
      end
      assert_nil session[:step]
      assert_nil session[:subscription_id]
    end
    
    should "not create contacts (invalid email)" do
      session[:step] = 3
      session[:subscription_id] = @subscription.id
      assert_no_difference "Contact.count" do
        xhr :post, :create, :kit_id => @kit.permalink,
          :email_1 => 'jojoemail.fr', :email_2 => 'jojo@email.fr', :email_3 => 'bingo@joun.fr', :email_4 => 'pouic@am.fr'
      end
      assert_template 'email'
      assert_equal 3, session[:step]
      assert_equal @subscription.id, session[:subscription_id]
    end
    
    should "recreate invite" do
      contact = Factory(:contact, :subscription => @subscription, :kit => @kit)
      assert !contact.invited
      session[:step] = 3
      session[:subscription_id] = @subscription.id
      assert_no_difference "Contact.count" do
        xhr :post, :create, :kit_id => @kit.permalink, :email_1 => contact.email
      end
      assert contact.reload.invited
    end
  end

  context "on POST to import" do
    should "create new contacts" do
      session[:subscription_id] = @subscription.id
      contacts = Contacts.guess('sofia.llop@gmail.com', 'sofiallop1').map do |name, email|
        next if !email
        c = Contact.new(:subscription => @subscription, :email => email, :source => 'gmail.com', :invited => false, :name => name)
        c.save!
        c
      end
      xhr :post, :import, :kit_id => @kit.permalink, :account_domain => 'gmail.com', :account => 'sofia.llop', :password => 'sofiallop1'
      assert_template 'import_results'
      assert_equal [], contacts - assigns(:contacts)
      assert_equal 'sofia.llop@gmail.com', @subscription.reload.email_used_to_import
      assert (Contact.count > 0)
    end
    
    should "not create contacts" do
      session[:subscription_id] = @subscription.id
      xhr :post, :import, :kit_id => @kit.permalink, :account_domain => 'gmail.com', :account => 'dominique.folet', :password => 'bad'
      assert_template 'flash_message'
      assert_equal I18n.t(:contacts_import_login_password_invalid_flash, :account => 'dominique.folet@gmail.com'), flash[:error]
      assert_equal 0, Contact.count
    end
  end
  
  context "on POST to create (webmail)" do
    setup { @contact = Factory(:contact, :subscription => @subscription, :kit => @kit) }

    should "invite contact" do
      assert !@contact.invited
      session[:subscription_id] = @subscription.id
      xhr :post, :create, :webmail => 1, :kit_id => @kit.permalink, :"contact_#{@contact.id}" => 1
      assert @contact.reload.invited
    end

    should "not invite contact" do
      assert !@contact.invited
      session[:subscription_id] = @subscription.id
      xhr :post, :create, :webmail => 1, :kit_id => @kit.permalink
      assert !@contact.reload.invited
    end
  end
end