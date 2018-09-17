require 'uri'

class User < ApplicationRecord
  has_one :giver
  has_one :receiver
  has_many :offers, through: :giver
  has_many :requests, through: :receiver
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :zip_code, presence: true, length: { is: 5 }
  validates :password, presence: true
  validates :password_confirmation, presence: true

end
