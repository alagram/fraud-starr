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
end