require 'spec_helper'

describe Admin::FraudsController do
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
end