class Offer < ApplicationRecord
  belongs_to :giver
  has_one :user, through: :giver
  has_many :requests
  has_many :requestors, through: :requests

  validates :headline, presence: true
end
