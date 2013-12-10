class UsersController < ApplicationController

  before_filter :require_user, only: [:edit, :update]

  def new
    @user = RegularUser.new
  end

  def create
    @user = RegularUser.new(regular_user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome."
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