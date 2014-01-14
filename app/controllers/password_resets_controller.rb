class PasswordResetsController < ApplicationController
  def show
    user = RegularUser.where(token: params[:id]).first
    if user
      @token = user.token
    else
      redirect_to expired_token_path
    end
  end

  def create
    user = RegularUser.where(token: params[:token]).first
    if user
      user.password = params[:password]
      unless user.password.blank?
        user.generate_token
        user.save
        flash[:success] = "Your password has been changed. Please sign in."
        redirect_to sign_in_path
      else
        flash[:error] = "Password cannot be blank."
        redirect_to :back
      end
    else
      redirect_to expired_token_path
    end
  end
end