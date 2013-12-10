class SessionsController < ApplicationController
  def new
    redirect_to root_path if current_user
  end

  def create
  end

  def destroy
  end

  def failure
    # redirect_to root_path, alert: "Authentication failed, please try again."
  end
end