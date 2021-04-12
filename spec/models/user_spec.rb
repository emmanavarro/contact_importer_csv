# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: 'user@example.com', password: '1234567') }

  describe 'association' do
    it { should have_many(:contacts).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user.password = nil
      expect(user).to_not be_valid
    end
  end
end
