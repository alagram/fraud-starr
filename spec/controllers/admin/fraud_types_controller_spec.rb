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

  describe "GET edit" do

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end

    it "sets @fraud_type" do
      set_current_admin
      fraud_type = Fabricate(:fraud_type)
      get :edit, id: fraud_type.id
      expect(assigns(:fraud_type)).to eq(fraud_type)
    end

    it "redirects the regular user to the root path" do
      set_current_user
      fraud_type = Fabricate(:fraud_type)
      get :edit, id: fraud_type.id
      expect(response).to redirect_to root_path
    end

    it "sets the flash error mesaage for the regular user" do
      set_current_user
      fraud_type = Fabricate(:fraud_type)
      get :edit, id: fraud_type.id
      expect(flash[:error]).to be_present
    end
  end

  describe "PATCH update" do
    context "with valid attributes" do

      it "redirects the regular user to the root path" do
        fraud_type = Fabricate(:fraud_type)
        set_current_user
        patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type)
        expect(response).to redirect_to root_path
      end

      it "sets @fraud_type" do
        set_current_admin
        fraud_type = Fabricate(:fraud_type)
        patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type)
        expect(assigns(:fraud_type)).to eq(fraud_type)
      end

      it "changes attributes of fraud type" do
        set_current_admin
        fraud_type = Fabricate(:fraud_type)
        patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type, name: "Facebook")
        expect(fraud_type.reload.name).to eq("Facebook")
      end

      it "redirects to the admin_fraud_type_path" do
        set_current_admin
        fraud_type = Fabricate(:fraud_type)
        patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type, name: "Facebook")
        expect(response).to redirect_to admin_fraud_type_path
      end
    end

    context "wit invalid attributes" do
      it "does not change attributes of fraud type" do
        set_current_admin
        fraud_type = Fabricate(:fraud_type)
        patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type, name: nil)
        expect(fraud_type.reload.name).to_not eq(nil)
      end

      it "renders edit page" do
        set_current_admin
        fraud_type = Fabricate(:fraud_type)
        patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type, name: nil)
        expect(response).to render_template :edit
      end
    end

    it_behaves_like "requires sign in" do
      fraud_type = Fabricate(:fraud_type)
      let(:action) { patch :update, id: fraud_type.id, fraud_type: Fabricate.attributes_for(:fraud_type, name: "Facebook") }
    end
  end
end