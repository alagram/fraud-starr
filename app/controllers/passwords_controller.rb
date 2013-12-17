class PasswordsController < ApplicationController
  def new
  end

  def create
    user = RegularUser.where(email: params[:email]).first
    if user
      AppMailer.send_password(user).deliver
      redirect_to password_confirmation_path
    else
      flash[:error] = "Email cannot be blank."
      redirect_to new_password_path
    end
  end
end