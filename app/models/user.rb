require 'uri'

class User < ApplicationRecord
  has_one :giver
  has_one :requestor
  has_many :offers, through: :giver
  has_many :requests, through: :requestor
  has_secure_password
  # accepts_nested_attributes_for :requests

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, allow_blank: true, length: { is: 10 }, format: { with: /\A[0-9]*\z/,
    message: "only allows numbers" }
  validates :city, presence: true, on: :update
  validates :state, presence: true, on: :update
  validates :password, presence: true, allow_nil: true
  validates :password_confirmation, presence: true, allow_nil: true

  def city_state
    "#{city}, #{state}"
  end
  
  def karma
    # number of requests marked completed by other users' givers and requestors
    giver.requests.select { |r| r.completed_giver }.count + requestor.requests.select { |r| r.completed_requestor }.count
  end
end
