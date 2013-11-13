require 'spec_helper'

describe FraudsController do
  describe "GET new" do
    it "sets the @fraud variable" do
      twitter = Fabricate(:fraud_type)

      get :new, fraud_type_id: twitter.id
      expect(assigns(:fraud)).to be_new_record
      expect(assigns(:fraud)).to be_instance_of(Fraud)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      it "redirects to register fraud page" do
        twitter = Fabricate(:fraud_type, name: "Twitter")
        twitter_field = Fabricate(:fraud_field, fraud_type_id: twitter.id)
        post :create, fraud: Fabricate.attributes_for(:fraud), fraud_type_id: twitter.id, properties: { twitter_field.name => "@agram" }
        expect(response).to redirect_to register_fraud_path
      end
      it "creates a fraudulent event"
      it "sets the flash success message"
    end

    context "with invalid inputs" do
      it "does not create a fraudulent event"
      it "renders the :new template"
      it "sets the flash error message"
    end
  end
end