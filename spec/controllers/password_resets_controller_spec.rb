require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if the token is valid"
    it "redirects to the expired token page if the taken is not valid"
  end
end