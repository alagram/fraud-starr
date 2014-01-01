require 'spec_helper'

describe Admin::FraudTypesController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    it "sets @fraud_type to a new FraudType" do
      set_current_admin
      get :new
      expect(assigns(:fraud_type)).to be_instance_of FraudType
      expect(assigns(:fraud_type)).to be_new_record
    end
  end
end