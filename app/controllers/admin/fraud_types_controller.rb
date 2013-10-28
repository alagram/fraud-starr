class Admin::FraudTypesController < ApplicationController

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
    @fraud_type = FraudType.find(params[:id])
  end

  def edit
    @fraud_type = FraudType.find(params[:id])
  end

  def update
    @fraud_type = FraudType.find(params[:id])

    if @fraud_type.update_attributes(fraud_type_params)
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
end