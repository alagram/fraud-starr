require 'spec_helper'

feature 'User registers fraudulent event' do
  
  scenario 'with valid fraud info', js: true do
   twitter = Fabricate(:fraud_type, name: "Twitter")
   facebook = Fabricate(:fraud_type, name: "Facebook")
   Fabricate(:fraud_field, fraud_type_id: twitter.id)
   alice = Fabricate(:user)


    visit root_path
    sign_in(alice)
    visit report_fraud_path
    select "Twitter", from: "Fraud Type"
    click_button "New Fraud Event"
    
    fill_in "Twitter handle", with: "@agram"
    fill_in "Title", with: "My fraud"
    fill_in "Description", with: "A very unfortunate event."
    fill_in "Fraud date", with: "2013-11-08"
    attach_file "upload-image", ["#{Rails.root}/spec/support/uploads/looper.jpg", "#{Rails.root}/spec/support/uploads/marigold.jpg", "#{Rails.root}/spec/support/uploads/argo.jpg"]
    click_button "Create Fraud"
    expect(page).to have_content("Fraudulent event successfully added.")
  end

  scenario 'with invalid fraud info', js: true do
    twitter = Fabricate(:fraud_type, name: "Twitter")
    facebook = Fabricate(:fraud_type, name: "Facebook")
    Fabricate(:fraud_field, name: "Facebook Address", fraud_type_id: facebook.id)
    kofi = Fabricate(:user)

    visit root_path
    sign_in(kofi)
    visit report_fraud_path
    select "Facebook", from: "Fraud Type"
    click_button "New Fraud Event"

    fill_in "Facebook address", with: "www.yahoo.com"
    fill_in "Title", with: "My Facebook fraud"
    fill_in "Description", with: "A very unfortunate event."
    fill_in "Fraud date", with: "2013-11-08"
    attach_file "upload-image", "#{Rails.root}/spec/support/uploads/marigold.jpg"
    click_button "Create Fraud"
    expect(page).to have_content("Facebook address must be a valid Facebook URL")
  end
end