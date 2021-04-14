class CreditCard < ApplicationRecord
  def initiliaze(credit_card)
    @credit_card = credit_card
  end

  def card_last_digits
    @credit_card.last(4)
  end

  def encrypt
    BCrypt::Password.create(@credit_card)
  end
end
