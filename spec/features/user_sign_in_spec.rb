require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
    bob = Fabricate(:regular_user)
    visit sign_in_path
    fill_in "email", with: bob.email
    fill_in "password", with: bob.password
    click_button "Sign In"
    expect(page).to have_content "Report Fraud!"
  end
end