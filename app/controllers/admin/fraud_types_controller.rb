class Admin::FraudTypesController < ApplicationController
  before_filter :require_user
  before_filter :require_admin
  before_action :set_fraud_type, only: [:show, :edit, :update]

  def index
  end

  def new
    @fraud_type = FraudType.new
  end

  def create
    @fraud_type = FraudType.new(fraud_type_params)

    if @fraud_type.save
      flash[:success] = 'Fraud type was succesfully created.'
      redirect_to admin_fraud_types_path
    else
      flash[:error] = 'Fraud type not created.'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @fraud_type.update(fraud_type_params)
      flash[:success] = 'Fraud type was succesfully updated.'
      redirect_to admin_fraud_type_path
    else
      flash[:error] = 'Fraud type not edited.'
      render :edit
    end
  end


  private

  def fraud_type_params
    params.require(:fraud_type).permit!
  end

  def set_fraud_type
    @fraud_type = FraudType.find(params[:id])
  end
end