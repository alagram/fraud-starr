class UsersController < ApplicationController

  def new
    @user = User.new
    redirect_to root_path if current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to sign_in_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end