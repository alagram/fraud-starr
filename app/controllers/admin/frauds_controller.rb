class Admin::FraudsController < ApplicationController
  before_action :require_user
  before_action :require_admin
  before_action :set_fraud

  def edit
  end

  def update
    if @fraud.update(fraud_params)
      flash[:success] = "Fraudulent event successfully updated."
      redirect_to edit_admin_fraud_path
    else
      render :edit
    end
  end

  private

  def set_fraud
    @fraud = Fraud.includes(:images).find(params[:id])
  end

  def fraud_params
    params.require(:fraud).permit!
  end
end