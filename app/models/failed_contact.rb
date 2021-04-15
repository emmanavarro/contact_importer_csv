class FailedContact < ApplicationRecord
  belongs_to :user

  validates_presence_of :error, message: "Can't be blank"
  validate :credit_card_validations
  after_validation :credit_card_encrypt

  def credit_card_validations
    CreditCard.new(@credit_card)
    self.franchise = CreditCardValidations::Detector.new(credit_card).brand_name
  end

  def credit_card_encrypt
    self.credit_card = CreditCard.new(@credit_card).encrypt
  end
end
