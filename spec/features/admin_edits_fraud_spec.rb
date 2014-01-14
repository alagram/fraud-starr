require 'spec_helper'

feature 'Admin edits fraud' do
  scenario 'Admin succesfully edits fraud' do
    admin = Fabricate(:admin)
    fraud = Fabricate(:fraud)
    sign_in(admin)
    visit edit_admin_fraud_path(fraud)

    select "Verified", from: "Status"
    click_button "Approve"

    expect(page).to have_content("Fraudulent event successfully updated.")
  end
end