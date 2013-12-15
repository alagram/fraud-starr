require 'spec_helper'
require 'bcrypt'

describe OAuthUser do
  describe "#login_or_create" do

    context "with omniauth twitter hash" do

      let(:twitter_hash) { OmniAuth.config.mock_auth[:twitter] }

      it "creates a new user" do
        auth = OAuthUser.new(twitter_hash)
        auth.login_or_create
        expect(User.count).to eq(1)
      end
      it "creates a new account associated with the user if account does not exist" do
        auth = OAuthUser.new(twitter_hash)
        auth.login_or_create
        expect(User.first.accounts.size).to eq(1)
      end
      it "creates a new account if the user exist" do
        alice = Fabricate(:regular_user)
        auth = OAuthUser.new(twitter_hash, alice)
        auth.login_or_create
        expect(alice.accounts.size).to eq(1)
      end
      it "does not create an account if it already exist" do
        auth = OAuthUser.new(twitter_hash)
        auth.login_or_create
        auth.login_or_create
        expect(User.first.accounts.size).to eq(1)
      end
    end

    context "with omniauth facebook hash" do

      let(:facebook_hash) { OmniAuth.config.mock_auth[:facebook] }

      it "creates a new user" do
        auth = OAuthUser.new(facebook_hash)
        auth.login_or_create
        expect(User.count).to eq(1)
      end
      it "creates a new account associated with the user if account does not exist" do
        auth = OAuthUser.new(facebook_hash)
        auth.login_or_create
        expect(User.first.accounts.size).to eq(1)
      end
      it "creates a new account if the user exist" do
        bob = Fabricate(:regular_user)
        auth = OAuthUser.new(facebook_hash, bob)
        auth.login_or_create
        expect(bob.accounts.size).to eq(1)
      end
      it "does not create an account if it already exist" do
        auth = OAuthUser.new(facebook_hash)
        auth.login_or_create
        auth.login_or_create
        expect(User.first.accounts.size).to eq(1)
      end
    end
  end
end