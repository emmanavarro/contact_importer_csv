class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :contacts, dependent: :destroy
  has_many :import_files, dependent: :destroy
  has_many :failed_contacts, dependent: :destroy

  validates :email, email: true, uniqueness: true, length: { maximum: 100 }
end
