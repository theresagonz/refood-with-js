class Offer < ApplicationRecord
  belongs_to :giver
  has_many :requests
  has_many :receivers, through: :requests

  validates :title, presence: true
end
