require 'spec_helper'

describe PasswordsController do
  describe "POST create" do
    context "with blank input" do
      it "redirects to the new password page" do
        post :create, email: ''
        expect(response).to redirect_to new_password_path
      end
      it "shows an error message" do
        post :create, email: ''
        expect(flash[:error]).to eq("Email cannot be blank.")
      end
    end
    context "with existing email"
    context "with non-existing email"
  end
end