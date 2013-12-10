class UsersController < ApplicationController

  before_filter :require_user, only: [:edit, :update]

  def new
    @user = RegularUser.new
    redirect_to root_path if current_user
  end

  def create
    @user = RegularUser.new(regular_user_params)
    if @user.save
      flash[:success] = "Thank you for registering. Please sign in."
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  private

  def regular_user_params
    params.require(:regular_user).permit!
  end
end