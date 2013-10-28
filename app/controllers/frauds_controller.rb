class FraudsController < ApplicationController
  def new
    @fraud = Fraud.new(fraud_type_id: params[:fraud_type_id])
  end

  def create
    @fraud = Fraud.new(fraud_params)
    
    if @fraud.save
      flash[:success] = 'Fraud event successfully created.'
      redirect_to register_fraud_path
    else
      flash[:error] = 'Fraud event not created.'
      render :new
    end
  end

  def edit
    @fraud = Fraud.find(params[:id])
  end

  def update
    @fraud = Fraud.find(params[:id])

    if @fraud.save
      flash[:success] = 'Fraud event successfully updated.'
      redirect_to @fraud
    else
      flash[:error] = 'Fraud event not updated.'
      render :edit
    end
  end


  private

  def fraud_params
    params.require(:fraud).permit!
  end
end