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

    context "with existing email" do
      it "redirects to the password confirmation page" do
        Fabricate(:regular_user, email: "alice@example.com")
        post :create, email: "alice@example.com"
        expect(response).to redirect_to password_confirmation_path
      end
      it "sends out an email to email address" do
        Fabricate(:regular_user, email: "alice@example.com")
        post :create, email: "alice@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["alice@example.com"])
      end
    end

    context "with non-existing email"
  end
end