require File.dirname(__FILE__) + '/../test_helper'

class ApplicationNotifierTest < ActionMailer::TestCase
  include ActionController::UrlWriter
  include ApplicationHelper
  
  DUMP_EMAILS = true
  
  default_url_options[:host] = EMAILING_HOST
  
  def setup
    @kit = Factory(:kit)
    @subscription = Factory(:subscription, :kit => @kit)
  end
  
  context 'emailing' do
    should "send emailing instructions" do
      response = ApplicationNotifier.deliver_emailing(@kit, 'julien@email.fr')
      assert_equal [EMAIL_NO_REPLY], response.from
      assert_equal ['julien@email.fr'], response.to
      assert_equal I18n.t(:mailer_emailing_subject, :kit_name => @kit.name), response.subject
      assert_matches(response.body, kit_url(@kit, :email => 'julien@email.fr', :anchor => 'body'),
        rules_kit_url(@kit, :email => 1), @kit.email1_picture.url)
      dump_email_body(:emailing, response.body)
    end
  end

  context 'confirmation' do
    should "send confirmation" do
      response = ApplicationNotifier.deliver_confirmation(@subscription)
      assert_equal [EMAIL_NO_REPLY], response.from
      assert_equal [@subscription.email], response.to
      assert_equal I18n.t(:mailer_confirmation_subject, :kit_name => @kit.name), response.subject
      assert_matches(response.body, congrats_kit_url(@kit, :anchor => 'body'), @kit.email2_picture.url)
      dump_email_body(:confirmation, response.body)
    end
  end

  context 'invite' do
    should "send invite" do
      contact = Factory(:contact, :subscription => @subscription, :kit => @kit)
      response = ApplicationNotifier.deliver_invite(contact)
      assert_equal [@subscription.email], response.from
      assert_equal [contact.email], response.to
      assert_equal I18n.t(:mailer_invite_subject, :kit_name => @kit.name), response.subject
      assert_matches(response.body, kit_url(@kit, :email => contact.email, :parent => @subscription.id, :anchor => 'body').gsub('&', '&amp;'), rules_kit_url(@kit, :email => 1), @kit.email1_picture.url, @subscription.name)
      dump_email_body(:invite, response.body)
    end
  end

  def assert_matches(body, *fields)
    fields.each { |f| assert_match /#{Regexp.escape(f.to_s)}/, body }
  end
  
  private
    def dump_email_body(sender, body)
      File.open("#{RAILS_ROOT}/tmp/emails/EMAIL_#{sender}.html", 'w') { |f| f.write(body) } if DUMP_EMAILS
    end
end