class User < ApplicationRecord
  has_one :giver
  has_one :receiver
  has_many :offers, through: :giver
  has_many :offers, through: :receiver
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true
  validates :password_confirmation, presence: true

end
