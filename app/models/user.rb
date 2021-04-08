class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, email: true, uniqueness: true, length: { maximum: 100 }
end
