require 'spec_helper'

describe FraudsController do
  describe "GET new" do
    it "sets the @fraud variable" do
      set_current_user
      twitter = Fabricate(:fraud_type)
      get :new, fraud_type_id: twitter.id
      expect(assigns(:fraud)).to be_new_record
      expect(assigns(:fraud)).to be_instance_of(Fraud)
    end
  end

  describe "GET show" do
    it "sets @fraud instance variable" do
      fraud = Fabricate(:fraud)
      get :show, id: fraud.token
      expect(assigns(:fraud)).to eq(fraud)
    end
  end

  describe "POST create" do

    context "with valid inputs" do

      before { set_current_user }
      let(:bob) { current_user }

      it "redirects to report fraud page" do
        post :create, fraud: Fabricate.attributes_for(:fraud)
        expect(response).to redirect_to report_fraud_path
      end
      it "creates a fraudulent event" do
        post :create, fraud: Fabricate.attributes_for(:fraud)
        expect(Fraud.count).to eq(1)
      end
      it "creates a fraudulent event associated with uploaded evidence" do
        post :create, fraud: Fabricate.attributes_for(:fraud)
        expect(Fraud.first.images).to eq([Image.first])
      end
      it "creates a fraudulent event associated with signed in user" do
        post :create, fraud: Fabricate.attributes_for(:fraud)
        expect(Fraud.first.user).to eq(bob)
      end
      it "creates a fraudulent event associated with multiple uploaded evidence" do
        image_params = Fabricate.attributes_for(:image)
        image_params_1 = Fabricate.attributes_for(:image)
        post :create, fraud: Fabricate.attributes_for(:fraud, images_attributes: [image_params, image_params_1])
        expect(Fraud.first.images.size).to eq(2)
      end
      it "sets the flash success message" do
        post :create, fraud: Fabricate.attributes_for(:fraud)
        expect(flash[:success]).to eq("Fraudulent event successfully added.")
      end
    end

    context "with invalid inputs" do

      before do
        set_current_user
        post :create, fraud: Fabricate.attributes_for(:fraud, title: "")
      end

      it "does not create a fraudulent event" do
        expect(Fraud.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET search" do
    it "sets @results instance variable" do
      fraud1 = Fabricate(:fraud)
      fraud2 = Fabricate(:fraud, title: "Another one")
      get :search, q: "@agram"
      expect(assigns(:results)).to match_array([fraud1, fraud2])
    end
  end
end
