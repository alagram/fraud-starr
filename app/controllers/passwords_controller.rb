class PasswordsController < ApplicationController
  def new
  end

  def create
    flash[:error] = "Email cannot be blank."
    redirect_to new_password_path
  end
end