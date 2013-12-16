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
  scenario "with invalid email and password" do
    bob = Fabricate(:regular_user)
    visit sign_in_path
    fill_in "email", with: bob.email
    fill_in "password", with: "incorrect"
    click_button "Sign In"
    expect(page).to have_content "Invalid login credentials."
  end
  scenario "with existing omniauth account" do
    acct = Fabricate(:account)
    visit sign_in_path
    click_on "Sign In with Twitter"
    expect(page).to have_content "Signed in successfully."
  end
  scenario "with new omniauth account" do
    OmniAuth.config.mock_auth[:twitter]
    visit sign_in_path
    click_on "Sign In with Twitter"
    expect(page).to have_content "Signed in successfully."
  end
end