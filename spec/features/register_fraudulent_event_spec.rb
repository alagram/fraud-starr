require 'spec_helper'

feature 'User registers fraudulent event' do
  background do
    Fabricate(:fraud_type, name: "Twitter")
  end
  
  scenario 'with twitter fraud type' do
    visit root_path
    visit register_fraud_path
    select "Twitter", from: "Fraud Type"
    click_button "New Fraud Event"
    expect(page).to have_content("Add New Fraudulent Event")
  end
end