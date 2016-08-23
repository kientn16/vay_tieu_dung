class ApplicationController < ActionController::Base
  helper_method :current_user,:current_admin
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
  def authorize
    redirect_to get_login_path unless current_user
  end

  def authorize_admin
    redirect_to get_login_admin_path unless current_admin
  end


end
