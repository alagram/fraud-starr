require 'spec_helper'

describe Admin::FraudTypesController do
  describe "GET new" do
    it "sets @fraud_type to a new FraudType" do
      get :new
      expect(assigns(:fraud_type)).to be_instance_of FraudType
      expect(assigns(:fraud_type)).to be_new_record
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "creates a fraud type"
      it "redireects to the add new fraud type page"
      it "sets the flash success message"
    end

    context "with invalid input" do
      it "does not create a fraud type"
      it "renders the :new template"
      it "sets the @fraud_type variable"
      it "sets the flash error message"
    end
  end
end