class PartnerSubscriptionsController < ApplicationController
  before_filter :get_subscription
  before_filter :set_locale

  def create
    @fails = []
    @ps = []
    PartnerSubscription.transaction do
      @kit.partners.each do |part|
        @error ||= params[:"partner_#{part.id}_choice"].blank?
        break if @error
        next unless params[:"partner_#{part.id}_choice"] == '1'
        ps = PartnerSubscription.new(
              :subscription => @subscription, :partner => part, :extra_field_value => params[:"partner_#{part.id}_extra"])
        ps.valid? ? @ps << ps : @fails << part
      end
    end
    
    if !@fails.blank? || @error
      render :update do |page|
        @fails.each do |part|
          page.replace_html :"partner_#{part.id}", :partial => "partner", 
            :locals => { :part => part, :extra_field => params[:"partner_#{part.id}_extra"], :failed => true }
        end
        if @error
          flash[:error] = t(:partner_subscriptions_checkboxes_must_be_checked)
          page.replace_html :error, :partial => 'shared/flash_message'
        else
          page.replace_html :error, ''
        end
      end
      return
    end
    
    @ps.each(&:save)
    render :update do |page|
      @step = session[:step] = 3
      page.visual_effect :scroll_to, :menu
      page.replace_html :menu, :partial => 'shared/steps'
      page.replace :body, :partial => 'shared/steps_content'
    end
  end
end