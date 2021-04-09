require 'rails_helper'

RSpec.describe 'sign out', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password')
  end

  scenario 'destroy user session' do
    visit users_index_path
    click_link 'Log Out'
    expect(current_path).to eq(root_path)
    # expect(page).to have_text('Signed in successfully.')
  end
end
