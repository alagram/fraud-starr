class FraudsController < ApplicationController
  before_filter :require_user, only: [:new, :create, :show, :register]

  def index  
  end

  def new
    @fraud = Fraud.new(fraud_type_id: params[:fraud_type_id])
  end

  def create
    @fraud = Fraud.new(fraud_params)
    
    if @fraud.save
      flash[:success] = 'Fraudulent event successfully added.'
      redirect_to register_fraud_path
    else
      render :new
    end
  end

  def search
    @results = Fraud.search(params[:query])
  end

  def show
  end


  private

  def fraud_params
    params.require(:fraud).permit!
  end
end