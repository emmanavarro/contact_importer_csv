require 'rails_helper'

RSpec.describe 'sign in', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password')
  end

  scenario 'signs user in' do
    visit new_user_session_path
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(current_path).to eq(users_index_path)
    expect(page).to have_text('Signed in successfully.')
  end

end
