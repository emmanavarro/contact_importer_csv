require 'rails_helper'

RSpec.describe 'sign in', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password')
  end

  scenario 'signs user up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(current_path).to eq(user_registration_path)
    # expect(page).to have_text('Signed in successfully.')
  end
end
