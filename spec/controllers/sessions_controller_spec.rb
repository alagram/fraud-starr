require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the root path for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do

    context "with regular user" do
      let!(:david) { Fabricate(:regular_user) }

      context "with valid credentials" do

        before do
          post :create, email: david.email, password: david.password
        end

        it "puts the signed in user in the session" do
          expect(session[:user_id]).to eq(david.id)
        end

        it "redirects to root path" do
          expect(response).to redirect_to root_path
        end
      end

      context "with invalid credentials" do

        before do
          post :create, email: david.email, password: david.password + 'asdfght'
        end

        it "does not put the siged in user in the session" do
          expect(session[:user_id]).to be_nil
        end
        it "redirects to the sign in page" do
          expect(response).to redirect_to sign_in_path
        end
        it "sets the flash error message" do
          expect(flash[:error]).not_to be_blank
        end
      end
    end
  end

  describe "GET destroy" do

    before do
      set_current_user
      get :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end