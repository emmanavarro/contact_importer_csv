class FailedContact < ApplicationRecord
  belongs_to :user

  validates_presence_of :error, message: "Can't be blank"
  validate :credit_card_validations
  after_validation :credit_card_encrypt

  def credit_card_validations
    CreditCard.new(credit_card)
    self.franchise = CreditCardValidations::Detector.new(credit_card).brand_name
    if franchise
      self.last_digits = CreditCard.new(last_digits).last(4)
    else
      errors.add(:credit_card, 'invalid credit card number')
      errors.add(:franchise, 'invalid credit card number')
    end
  end

  def credit_card_encrypt
    self.credit_card = CreditCard.new(@credit_card).encrypt
  end
end
