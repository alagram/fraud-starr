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
    context "with valid credentials" do
      it "puts the signed in user in the session" do
        david = Fabricate(:user)
        post :create, email: david.email, password: david.password
        expect(session[:user_id]).to eq(david.id)
      end

      it "redirects to root path" do
        david = Fabricate(:user)
        post :create, email: david.email, password: david.password
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid credentials" do
      it "does not put the siged in user in the session" do
        david = Fabricate(:user)
        post :create, email: david.email, password: david.password + 'asdfght'
        expect(session[:user_id]).to be_nil
      end
      it "redirects to the sign in page" do
        david = Fabricate(:user)
        post :create, email: david.email, password: david.password + 'asdfght'
        expect(response).to redirect_to sign_in_path
      end
      it "sets the flash error message" do
        david = Fabricate(:user)
        post :create, email: david.email, password: david.password + 'asdfght'
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do
    it "clears the session for the user" do
      set_current_user
      get :destroy
      expect(session[:user_id]).to be_nil
    end
    it "redirects to the root path" do
      set_current_user
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end