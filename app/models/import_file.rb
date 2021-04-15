class ImportFile < ApplicationRecord
  belongs_to :user

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_elements = row.to_h
      contact = Contact.new(
        name: contact_elements['name'], birthday: contact_elements['birthday'], phone: contact_elements['phone'],
        address: contact_elements['address'], credit_card: contact_elements['credit_card'],
        franchise: CreditCardValidations::Detector.new(contact_elements['credit_card']).brand_name,
        last_digits: (contact_elements['credit_card']).last(4), email: contact_elements['email'], user_id: user.id
      )
      failed_contact!(user, contact, contact_elements) unless contact.save
    end
  end

  def self.failed_contact!(user, contact, contact_elements)
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
  end

end
