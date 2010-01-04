class Admin::UserSessionsController < ApplicationController
  before_filter :require_user, :only => :destroy
  
  def new
    unless session[:return_to]
      session[:return_to] = request.referer if (request.referer =~ /^http:\/\/#{EMAILING_HOST}/) == 0
    end
    if logged_in?
      @user = @current_user
      redirect_to admin_stats_path
      return
    end
    @user_session = UserSession.new
    @user = User.new
  end

  def create
  redirect_to admin_stats_path and return if logged_in?
   @user_session = UserSession.new(params[:user_session])
   if User.find_by_email(params[:user_session][:email]) && @user_session.save
     redirect_back_or_default admin_stats_path
   else
     @user = User.new
     flash[:notice] = t(:user_sessions_auth_failed_flash)
     render :new
   end
  end

  def destroy
   @current_user_session.destroy
   flash[:notice] = t(:user_sessions_destroy_flash)
   redirect_to new_admin_user_session_path
  end
end