require 'spec_helper'

feature 'User registers fraudulent event' do
  
  scenario 'with twitter fraud type' do
   twitter = Fabricate(:fraud_type, name: "Twitter")
   facebook = Fabricate(:fraud_type, name: "Facebook")
   Fabricate(:fraud_field, name: "Twitter Handle", field_type: "text_field", required: true)

    visit root_path
    visit register_fraud_path
    select "Twitter", from: "Fraud Type"
    click_button "New Fraud Event"
    save_and_open_page
    
    fill_in "Twitter handle", with: "@agram"
    fill_in "Title", with: "My fraud"
    fill_in "Description", with: "A very unfortunate event."
    fill_in "Fraud date", with: "2013-11-08"
    attach_file "Upload Evidence", with: "spec/support/uploads/marigold.jpg"
    click_button "Create Fraud"
    expect(page).to have_content("Fraudulent event successfully added.")

  end
end