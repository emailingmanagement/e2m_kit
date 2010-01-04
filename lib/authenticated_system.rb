module AuthenticatedSystem
  
  module ClassMethods
  end
  
  module InstanceMethods
    protected
      def current_user
        @current_user ||= ( @current_user_session = UserSession.find ) && @current_user_session.user
      end

      def logged_in?
        current_user.try(:logged_in?)
      end

      def require_user
        return true if current_user
        store_location
        flash[:notice] = t(:user_sessions_user_must_be_logged_flash)
        redirect_to new_admin_user_session_path
        return false
      end

      def require_no_user
        if current_user
          store_location
          flash[:notice] = t(:user_sessions_user_must_not_be_logged_flash)
          redirect_to admin_kits_path
          return false
        end
      end

      def store_location
        session[:return_to] = request.request_uri
      end

      def redirect_back_or_default(default)
        redirect_to(session[:return_to] || default)
        session[:return_to] = nil
      end      
  end

  def self.included(receiver)
    receiver.extend ClassMethods
    receiver.class_eval do
      include InstanceMethods
      helper_method :current_user, :logged_in?
      filter_parameter_logging :password, :password_confirmation
    end
  end
end