class KitsController < ApplicationController
  before_filter :get_kit
  before_filter :set_locale

  layout 'kit'
  
  def show
    @step = (session[:step] || 1)
    @subscription = if session[:subscription_id]
      @kit.subscriptions.find_by_id(session[:subscription_id])
    else
      if params[:parent] && Subscription.find_by_id(params[:parent])
        session[:parent] = params[:parent]
      end
      if params[:s] && Source.find_by_id(params[:s])
        session[:source] = params[:s]
      end
      Subscription.new(:country => @kit.default_country, :email => params[:email])
    end
  end

  def rules
    @email = params[:email]
    render :action => 'rules', :layout => false
  end

  private
    def get_kit
      @kit = (Kit.find_by_permalink(params[:id]) || Kit.first)
      render_404 and return unless @kit
    end
end
