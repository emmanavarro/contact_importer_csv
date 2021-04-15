class ImportFile < ApplicationRecord
  include AASM
  belongs_to :user
  validates_presence_of :state

  aasm column: 'state' do
    state :processing, initial: true
    state :waiting, :failed, :complete

    event :complete_import do
      transitions from: %i[processing failed], to: :complete
    end

    event :fail_import do
      transitions from: :processing, to: :failed
    end
  end

  def import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_elements = row.to_h
      contact = Contact.new(
        name: contact_elements['name'], birthday: contact_elements['birthday'], phone: contact_elements['phone'],
        address: contact_elements['address'], credit_card: contact_elements['credit_card'],
        franchise: CreditCardValidations::Detector.new(contact_elements['credit_card']).brand_name,
        last_digits: (contact_elements['credit_card']).last(4), email: contact_elements['email'], user_id: user.id
      )
      if contact.save && may_complete_import?
        complete_import!
      else
        failed_contact!(user, contact, contact_elements)
      end
    end
  end

  def failed_contact!(user, contact, contact_elements)
    errors_msg = []
    errors_msg = contact.errors.full_messages.join(', ')
    failed_contact = FailedContact.new(
      name: contact_elements['name'], birthday: contact_elements['birthday'],
      phone: contact_elements['phone'], address: contact_elements['address'],
      credit_card: CreditCardValidations::Detector.new(contact_elements['credit_card']).brand_name,
      franchise: contact_elements['credit_card'], last_digits: contact_elements['credit_card'].last(4),
      email: contact_elements['email'],
      user_id: user.id, error: errors_msg
    )
    failed_contact.save
    fail_import! if may_fail_import?
  end
end
