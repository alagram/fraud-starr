class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def require_user
    redirect_to sign_in_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end
end
