class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  include AuthenticatedSystem

  protected
    def set_locale
      I18n.locale = @kit.lang
    end

    def get_kit
      render_404 and return unless @kit = Kit.find_by_permalink(params[:kit_id])
    end

    def get_subscription
      render_404 and return unless @subscription = Subscription.find_by_id(session[:subscription_id])
      @kit = @subscription.kit
    end

    def render_404
      logger.error "[404] - #{request.protocol}#{request.host}#{request.request_uri}"
      if request.xhr?
        render :nothing => true, :status => '404 Not Found'
      else
        # declarative_auth bug
        render('shared/error_404', :status => '404 Not Found', :layout => true) rescue redirect_to root_path
      end
    end
end
