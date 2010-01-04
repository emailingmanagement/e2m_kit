class ApplicationNotifier < ActionMailer::Base
  helper :application

  default_url_options[:host] = EMAILING_HOST
  
  def emailing(kit, email)
    from "\"#{kit.name}\" <#{EMAIL_NO_REPLY}>"
    recipients email
    subject I18n.t(:mailer_emailing_subject, :kit_name => kit.name)
    set_default this_method
    body :kit => kit, :email => email
  end
  
  def confirmation(subscription)
    kit = subscription.kit
    from "\"#{kit.name}\" <#{EMAIL_NO_REPLY}>"
    recipients "#{subscription.name} <#{subscription.email}>"
    subject I18n.t(:mailer_confirmation_subject, :kit_name => kit.name)
    set_default this_method
    body :subscription => subscription, :kit => kit
  end
  
  def invite(contact)
    subscription = contact.subscription
    kit = subscription.kit
    from "\"#{subscription.name}\" <#{subscription.email}>"
    recipients "#{contact.name} <#{contact.email}>"
    subject I18n.t(:mailer_invite_subject, :kit_name => kit.name)
    set_default this_method
    body :subscription => subscription, :contact => contact, :kit => subscription.kit
  end
  
  private
    def set_default(method_name, opts = {})
      headers 'return-path' => from
      sent_on Time.zone.now
      content_type 'text/html'
      template "#{method_name}_#{I18n.locale}"
    end
end