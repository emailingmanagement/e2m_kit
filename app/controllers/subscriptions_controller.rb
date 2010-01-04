class SubscriptionsController < ApplicationController
  before_filter :get_kit
  before_filter :check_honeypots, :only => [:create]
  before_filter :set_locale

  def create
    @subscription = Subscription.new(
      params[:subscription].merge(
        :kit => @kit, 
        :parent => Subscription.find_by_id(session[:parent]), :source => Source.find_by_id(session[:source])
      )
    )
    render :update do |page|
      if @subscription.save
        session[:subscription_id] = @subscription.id
        @step = session[:step] = 2
        page.replace_html :menu, :partial => 'shared/steps'
        page.replace :body, :partial => 'shared/steps_content'
        page.visual_effect :scroll_to, :menu
      else
        @step = 1
        page.replace_html :subscription, :partial => 'new'
      end
    end
  end

  def select_region_and_city
    @subscription = Subscription.new(:country => params[:country_code])
    render :update do |page|
      page.replace_html :select_region_and_city, :partial => 'select_region_and_city'
    end
  end
end