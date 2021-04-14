class Contact < ApplicationRecord
  belongs_to :user

  VALID_NAME_REGEX = /\A[a-zA-Z\s\-]+\z/
  VALID_PHONE_REGEX = /(\(\+\d{2}\)\s\d{3}\s\d{3}\s\d{2}\s\d{2})|(\(\+\d{2}\)\s\d{3}-\d{3}-\d{2}-\d{2})/

  validates_presence_of :name, :birthday, :phone, :address, :credit_card, :email
  validates :name, format: { with: VALID_NAME_REGEX, message: '- is the only special character allowed' }
  validate :valid_birthday
  validates :phone, format: { with: VALID_PHONE_REGEX,
                              message: '(+00) 000 000 00 00 or (+00) 000-000-00-00 are the only allowed formats' }
  validates :email, email: true, uniqueness: true, length: { maximum: 100 }
  # validate :credit_card_info
  after_validation :credit_card_encrypt

  def valid_birthday
    Date.iso8601(birthday)
  rescue ArgumentError
    errors.add(:birthday, 'only YYYYMMDD and YYYY-MM-DD formats are allowed')
  end

  def file_type_validation
    valid_type = ['text/csv']
    errors.add(:file, 'file must be of CSV type.') if file.attached? && !file.content_type.in?(valid_type)
  end

  # def credit_card_info
  #   self.last_digits = CreditCard.new(last_digits.to_h).card_last_digits
  # end

  def credit_card_encrypt
    self.credit_card = CreditCard.new(@credit_card).encrypt
  end

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|
      contact_elements = row.to_h
      contact = find_or_create_by!(name: contact_elements['name'], birthday: contact_elements['birthday'],
                                   phone: contact_elements['phone'], address: contact_elements['address'],
                                   credit_card: contact_elements['credit_card'],
                                   franchise: CreditCardValidations::Detector.new(
                                     contact_elements['credit_card']
                                   ).brand_name, last_digits: contact_elements['credit_card'],
                                   email: contact_elements['email'], user_id: user.id)
      contact.update(contact_elements)
    end
  end
end
