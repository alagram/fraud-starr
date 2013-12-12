require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(RegularUser)
    end
    it "redirects to root path if user is already signed in" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "with valid input" do

      before do
        post :create, regular_user: Fabricate.attributes_for(:regular_user)
      end

      it "creates a regular user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do

      before do
        post :create, regular_user: { email: "bob@example.com", password: "password1" }
      end

      it "does not create the regular user" do
        expect(User.count).to eq(0)
      end
      it "renders the new template" do
        expect(response).to render_template :new
      end
      it "sets @user variable" do
        expect(assigns(:user)).to be_instance_of(RegularUser)
      end
    end
  end
end