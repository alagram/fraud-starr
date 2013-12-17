class PasswordsController < ApplicationController
  def create
    user = RegularUser.where(email: params[:email]).first
    if user
      AppMailer.send_password(user).deliver
      redirect_to password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank." : "There is no user with that email in the system."
      redirect_to new_password_path
    end
  end
end