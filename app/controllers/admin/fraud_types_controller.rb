class Admin::FraudTypesController < ApplicationController

  def index
  end

  def new
    @fraud_type = FraudType.new
  end
end