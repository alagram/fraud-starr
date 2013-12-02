require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "redirects to root path if user is already signed in" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "creates the user" do
        post :create, user: { full_name: "Bob Smith", email: "bob@example.com", password: "password1" }
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        post :create, user: { full_name: "Bob Smith", email: "bob@example.com", password: "password1" }
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do
      it "does not create the user"
      it "renders the new template"
      it "sets @user variable"
    end
  end
end