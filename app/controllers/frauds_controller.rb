class FraudsController < ApplicationController
  before_action :require_user, only: [:new, :create, :register]

  def index
  end

  def new
    @fraud = Fraud.new(fraud_type_id: params[:fraud_type_id])
  end

  def create
    @fraud = Fraud.new(fraud_params.merge!(user: current_user))

    if @fraud.save
      flash[:success] = 'Fraudulent event successfully added.'
      redirect_to report_fraud_path
    else
      render :new
    end
  end

  def search
    @results = Fraud.search(params[:q])
  end

  def show
  end


  private

  def fraud_params
    params.require(:fraud).permit!
  end
end