# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
  end

  describe 'general validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:birthday) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:credit_card) }
    it { should validate_presence_of(:email) }
  end

  describe 'name field validations' do
    it { should allow_value('Yesid Lopez').for(:name) }
    it { should allow_value('Yesid-Lopez').for(:name) }
    it { should_not allow_value('Yesid#Lopez').for(:name).with_message('- is the only special character allowed') }
  end

  describe 'phone field validations' do
    it { should allow_value('(+57) 680 789 56 43').for(:phone) }
    it { should allow_value('(+57) 680-789-56-43').for(:phone) }
    it {
      should_not allow_value('57 680-789-56-43').for(:phone).with_message(
        '(+00) 000 000 00 00 or (+00) 000-000-00-00 are the only allowed formats'
      )
    }
    it {
      should_not allow_value('57 6807895643').for(:phone).with_message(
        '(+00) 000 000 00 00 or (+00) 000-000-00-00 are the only allowed formats'
      )
    }
  end

  describe 'email field validations' do
    Contact.new(
      name: 'Yesid Otero',
      phone: '(+57) 320-482-73-67',
      email: 'yesid@example.com',
      address: 'Cra 47 # 57 -90',
      birthday: '19911204',
      credit_card: '15628778935627430',
      user_id: 1
    )
    it { should allow_value('user@example.com').for(:email) }
    it {
      should_not allow_value('userexample.com').for(:email).with_message(
        'is not a valid email'
      )
    }
    it {
      should_not allow_value('user@example').for(:email).with_message(
        'is not a valid email'
      )
    }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
