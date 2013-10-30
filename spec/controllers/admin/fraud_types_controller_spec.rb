require 'spec_helper'

describe Admin::FraudTypesController do
  describe "GET new" do
    it "sets @fraud_type to a new FraudType" do
      get :new
      expect(assigns(:fraud_type)).to be_instance_of FraudType
      expect(assigns(:fraud_type)).to be_new_record
    end
  end
end