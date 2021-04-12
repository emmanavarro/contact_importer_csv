require 'rails_helper'

RSpec.describe 'sign up', type: :feature do
  scenario 'signs @user up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user_test@gmail.com'
    fill_in 'Password', with: 'secret'
    fill_in 'Password confirmation', with: 'secret'
    click_button 'Sign up'
    expect(current_path).to eq(users_index_path)
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end
end
