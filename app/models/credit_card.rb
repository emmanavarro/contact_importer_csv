class CreditCard < ApplicationRecord
  def initiliaze(credit_card)
    @credit_card = credit_card
  end

  def encrypt
    BCrypt::Password.create(@credit_card)
  end
end
