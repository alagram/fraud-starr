class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    if env["omniauth.auth"].present?
      oauth = OAuthUser.new(env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      redirect_to root_path, notice: "Signed in successfully."
    else
      user = RegularUser.where(email: params[:email]).first
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Signed in successfully."
      else
        flash.now[:error] = "Invalid login credentials."
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully."
  end

  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end