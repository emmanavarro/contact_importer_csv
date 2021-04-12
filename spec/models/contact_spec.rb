# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
  end

  describe 'general validations' do
    let(:contact) { Contact.new }
    let(:user) { User.new(email: 'emma.navarro@koombea.com', password: '123456') }

    it 'is valid' do
      contact = Contact.new(
        name: 'Yesid Lopez',
        phone: '(+57) 320-482-73-27',
        email: 'yesid@example.com',
        address: 'Cra 47 # 57 -90',
        birthday: '19911204',
        credit_card: '15628778935627434',
        user_id: 1
      )
      expect(contact).to be_valid
    end

    it 'is missing name' do
      contact.name = nil
      expect(contact).not_to be_valid
      expect(contact.errors[:name]).to include("can't be blank")
    end

    it 'is missing birthday' do
      contact.birthday = nil
      expect(contact).not_to be_valid
      expect(contact.errors[:birthday]).to include("can't be blank")
    end

    it 'is missing phone' do
      contact.phone = nil
      expect(contact).not_to be_valid
      expect(contact.errors[:phone]).to include("can't be blank")
    end

    it 'is missing address' do
      contact.address = nil
      expect(contact).not_to be_valid
      expect(contact.errors[:address]).to include("can't be blank")
    end

    it 'is missing credit card number' do
      contact.credit_card = nil
      expect(contact).not_to be_valid
      expect(contact.errors[:credit_card]).to include("can't be blank")
    end

    it 'is missing email' do
      contact.email = nil
      expect(contact).not_to be_valid
      expect(contact.errors[:email]).to include("can't be blank")
    end
  end

  describe 'name field validations' do
    it { should allow_value('Yesid Lopez').for(:name) }
    it { should allow_value('Yesid-Lopez').for(:name) }
    it { should_not allow_value('Yesid#Lopez').for(:name).with_message('- is the only special character allowed') }
  end

  
end
