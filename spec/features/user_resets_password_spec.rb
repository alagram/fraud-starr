require 'spec_helper'

feature 'User resets password' do
  scenario 'User successfully resets passowrd' do
    alice = Fabricate(:regular_user, password: 'old_password')
    visit sign_in_path
    click_link 'Need a new password?'
    fill_in 'email', with: alice.email
    click_button 'Send me reset instructions'

    open_email(alice.email)
    current_email.click_link('Reset My Password')

    fill_in 'password', with: 'new_password'
    click_button 'Reset Password'

    fill_in 'email', with: alice.email
    fill_in 'password', with: 'new_password'
    click_button 'Sign In'
    expect(page).to have_content("Welcome, #{alice.first_name}")

    clear_email
  end

  scenario 'User unsuccessfully resets password with blank password' do
    bob = Fabricate(:regular_user, password: 'old_password')
    visit sign_in_path
    click_link 'Need a new password?'
    fill_in 'email', with: bob.email
    click_button 'Send me reset instructions'

    open_email(bob.email)
    current_email.click_link('Reset My Password')

    fill_in 'password', with: nil
    click_button 'Reset Password'
    expect(page).to have_content("Password cannot be blank.")

    clear_email
  end
end