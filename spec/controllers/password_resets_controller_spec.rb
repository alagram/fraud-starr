require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid" do
      bob = Fabricate(:regular_user)
      bob.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end

    it "redirects to the expired token page if the taken is not valid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end

    it "sets @token" do
      bob = Fabricate(:regular_user)
      bob.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end
  end

  describe "POST create" do
    context "with valid token" do

      before do
        request.env["HTTP_REFERER"] = "where_i_came_from"
      end

      it "redirects to the sign in page" do
        alice = Fabricate(:regular_user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end
      it "updates the user's password" do
        alice = Fabricate(:regular_user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(alice.reload.authenticate('new_password')).to be_true
      end
      it "sets the flash success message" do
        alice = Fabricate(:regular_user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to be_present
      end
      it "regenerates the user token" do
        alice = Fabricate(:regular_user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(alice.reload.token).not_to eq('12345')
      end
      it "redirects to back if password is blank" do
        alice = Fabricate(:regular_user, password: 'old_password')
        alice.update_column(:token, '12345')
        post :create, token: '12345', password: nil
        expect(response).to redirect_to "where_i_came_from"
      end
    end

    context "with invalid token" do
      it "redirects to the expired token path" do
        post :create, token: '12345', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end