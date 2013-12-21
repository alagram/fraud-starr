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

    context "with existing email and token" do

      after { ActionMailer::Base.deliveries.clear }

      it "sends out an email to email address" do
        Fabricate(:regular_user, email: "bob@example.com")
        post :create, email: "bob@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["bob@example.com"])
      end
      it "redirects to the password confirmation page" do
        Fabricate(:regular_user, email: "alice@example.com")
        post :create, email: "alice@example.com"
        expect(response).to redirect_to password_confirmation_path
      end
      it "renders the new password page if token does not exist" do
        alice = Fabricate(:user, email: "alice@example.com")
        post :create, email: "alice@example.com"
        expect(response).to render_template :new
      end
      it "does not send an email if token does not exist" do
        alice = Fabricate(:user, email: "alice@example.com")
        post :create, email: "alice@example.com"
        expect(ActionMailer::Base.deliveries.last).to be_nil
      end
      it "shows error message if token does not exist" do
        alice = Fabricate(:user, email: "alice@example.com")
        post :create, email: "alice@example.com"
        expect(flash[:error]).to eq("There is no user with that email in the system.")
      end
    end

    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, email: "bar@example.com"
        expect(response).to redirect_to new_password_path
      end
      it "shows an error messgae" do
        post :create, email: "bar@example.com"
        expect(flash[:error]).to eq("There is no user with that email in the system.")
      end
    end
  end
end