class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
    auth = env['omniauth.auth']

    @authentication = Authentication.find_with_omniauth(auth)

    if @authentication.nil?
      @authentication = Authentication.create_with_omniauth(auth)
    end

    if signed_in?
      if @authentication.user == current_user
        redirect_to root_path, notice: "You have already linked this account"
      else
        @authentication.user = current_user
        @authentication.save
        redirect_to root_path, notice: "Account successfully authenticated"
      end
    else
      if @authentication.user.present?
        self.current_user = @authentication.user
        redirect_to root_path, notice: "Signed in!"
      else
        if @authentication.provider == 'identity'
          u = User.find(@authentication.uid)
        else
          u = User.create_with_omniauth(auth)
        end
        u.authentications << @authentication
        self.current_user = u
        redirect_to root_path, notice: "Welcome!"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end

  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end
end