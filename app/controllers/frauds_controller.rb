class FraudsController < ApplicationController

  def index  
  end

  def new
    @fraud = Fraud.new(fraud_type_id: params[:fraud_type_id])
  end

  def create
    @fraud = Fraud.new(fraud_params)
    
    if @fraud.save
      flash[:success] = 'Fraud event successfully created.'
      redirect_to register_fraud_path
    else
      render :new
    end
  end


  private

  def fraud_params
    params.require(:fraud).permit!
  end
end