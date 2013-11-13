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

      before do
        post :create, fraud: Fabricate.attributes_for(:fraud), properties: { "Twitter handle" => "@agram" }
      end

      it "redirects to register fraud page" do
        expect(response).to redirect_to register_fraud_path
      end
      it "creates a fraudulent event" do
        expect(Fraud.count).to eq(1)
      end
      it "sets the flash success message" do
        expect(flash[:success]).to eq("Fraudulent event successfully added.")
      end
    end

    context "with invalid inputs" do

      before do
        post :create, fraud: Fabricate.attributes_for(:fraud, title: ""), properties: { "Twitter handle" => "@agram" }
      end

      it "does not create a fraudulent event" do
        expect(Fraud.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end
end