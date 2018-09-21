class Offer < ApplicationRecord
  belongs_to :giver
  has_many :requests
  has_many :requestors, through: :requests
  has_many :receivers
  has_one :user, through: :giver

  validates :headline, presence: true
end
