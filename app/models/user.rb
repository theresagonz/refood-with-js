require 'uri'

class User < ApplicationRecord
  has_one :giver
  has_one :receiver
  has_many :offers, through: :giver
  has_many :requests, through: :receiver
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validates :phone, 
  validates :zip_code, presence: true, length: { is: 5 }
  validates :password, presence: true, allow_nil: true
  validates :password_confirmation, presence: true, allow_nil: true

end
