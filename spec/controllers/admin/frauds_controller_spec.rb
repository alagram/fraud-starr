require 'spec_helper'

describe Admin::FraudsController do

  describe "GET index" do

    it_behaves_like "requires sign in" do
      fraud = Fabricate(:fraud)
      let(:action) { get :index }
    end

    it "sets @frauds" do
      set_current_admin
      fraud_1 = Fabricate(:fraud)
      fraud_2 = Fabricate(:fraud)
      get :index
      expect(assigns(:frauds)).to match_array([fraud_1, fraud_2])
    end

  end

  describe "GET edit" do

    it_behaves_like "requires sign in" do
      fraud = Fabricate(:fraud)
      let(:action) { get :edit, id: fraud.id }
    end

    it "sets @fraud" do
      set_current_admin
      fraud = Fabricate(:fraud)
      get :edit, id: fraud.id
      expect(assigns(:fraud)).to eq(fraud)
    end

    it "redirects the regular user to the root path" do
      fraud = Fabricate(:fraud)
      set_current_user
      get :edit, id: fraud.id
      expect(response).to redirect_to root_path
    end

    it "sets the flash error message for regular user" do
      fraud = Fabricate(:fraud)
      set_current_user
      get :edit, id: fraud.id
      expect(flash[:error]).to be_present
    end
  end

  describe "PATCH update" do

    context "with valid attibutes" do

      it "redirects the regular user to the root path" do
        fraud = Fabricate(:fraud)
        set_current_user
        patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud)
        expect(response).to redirect_to root_path
      end

      it "sets @fraud" do
        set_current_admin
        fraud = Fabricate(:fraud)
        patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud)
        expect(assigns(:fraud)).to eq(fraud)
      end

      it "changes attributes of fraudulent event" do
        set_current_admin
        fraud = Fabricate(:fraud)
        patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud, status: "3")
        expect(fraud.reload.status).to eq("3")
      end

      it "should redirect_to edit admin fraud path" do
        set_current_admin
        fraud = Fabricate(:fraud)
        patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud, status: "3")
        expect(response).to redirect_to edit_admin_fraud_path
      end
    end

    context "with invalid attibutes" do
      it "does not change fraud attibutes" do
        set_current_admin
        fraud = Fabricate(:fraud)
        patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud, title: nil, status: "3")
        expect(fraud.reload.status).to_not eq("3")
      end

      it "renders edit page" do
        set_current_admin
        fraud = Fabricate(:fraud)
        patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud, title: nil, status: "3")
        expect(response).to render_template :edit
      end
    end

    it_behaves_like "requires sign in" do
      fraud = Fabricate(:fraud)
      let(:action) { patch :update, id: fraud.id, fraud: Fabricate.attributes_for(:fraud) }
    end
  end
end