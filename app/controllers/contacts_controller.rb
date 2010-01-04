class ContactsController < ApplicationController
  before_filter :get_subscription
  before_filter :set_locale
  
  def import
    if(@account = params[:account]).blank? || (@password = params[:password]).blank?
      flash[:error] = t(:contacts_import_login_password_required_flash)
      render_flash_import
      return
    end

    @account << "@#{params[:account_domain]}" unless params[:account_domain].blank?
    RAILS_DEFAULT_LOGGER.error "CONTACTS => [#{@account}][#{@password}]"
    begin
      timeout(30) do
        a = (@account).split('@')
        @account = (a.size > 2 ? "#{a[0]}@#{a[1]}" : @account)
        @contacts = Contacts.guess(@account, @password)
      end
    rescue Exception => e
      flash[:error] = t(:contacts_import_login_password_invalid_flash, :account => @account)
      render_flash_import
      return
    end

    if @contacts.blank?
      flash[:error] = t(:contacts_import_login_password_invalid_flash, :account => @account)
      render_flash_import
      return
    end
    Contact.transaction do
      @contacts.each do |name, email|
        next if !email || (email.downcase == @subscription.email.downcase) || Subscription.find_by_email(email)
        c = Contact.new(
              :subscription => @subscription, :email => email, :source => params[:account_domain], :invited => false, :name => name)
        if !c.save && !Subscription.find_by_email(email) && (contact = Contact.find_by_email(email))
          contact.subscription = @subscription
          contact.save
        end
      end
    end

    if (@contacts = @subscription.contacts.reload).blank?
      flash[:error] = t(:contacts_import_login_account_no_contacts, :account => @account)
      render_flash_import
      return
    end

    @subscription.update_attribute(:email_used_to_import, @account)

    render :update do |page|
      page.replace_html :import, :partial => 'import_results'
      page.hide :hr
      page.hide :emails
    end
  end
  
  def create
    params[:webmail] == '1' ? create_from_webmail : create_from_emails
  end

  def congrats
  end

  private
    def create_from_emails
      @contacts = []
      @fails = []
      1.upto(4) do |i|
        email = params[:"email_#{i}"]
        next if email.blank? || Subscription.find_by_email(email)
        c = Contact.new(:subscription => @subscription, :email => params[:"email_#{i}"], :source => 'emails', :invited => true)
        if c.valid?
          @contacts << c 
        elsif (contact = Contact.find_by_email(c.email))
          contact.subscription = @subscription
          contact.invited = true
          contact.save ? @contacts << contact : @fails << [i, c]
        else
          @fails << [i, c]
        end
      end
      unless @fails.blank?
        render :update do |page|
          @fails.each do |i, c|
            page.replace_html :"contact_email_#{i}", :partial => 'email', :locals => { :num => i, :failed => true, :email => c.email }
          end
        end
        return
      end
      @contacts.each(&:save)
      render_congrats
    end
    
    def create_from_webmail
      @subscription.contacts.each do |c|
        c.update_attribute(:invited, true) if params[:"contact_#{c.id}"] == '1'
      end
      render_congrats
    end
    
    def render_congrats
      ApplicationNotifier.deliver_confirmation(@subscription)
      session[:step] = session[:subscription_id] = nil
      render(:update) { |page| page.redirect_to congrats_kit_path(@kit, :anchor => 'body') }
    end
    
    def render_flash_import(level = :error)
      render :update do |page|
        page.replace_html :flash_import, :partial => 'shared/flash_message'
      end
    end
end
  