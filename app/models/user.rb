class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :borrowings, dependent: :destroy
  has_many :borrowed_books, through: :borrowings, source: :book

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
