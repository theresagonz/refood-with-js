class Offer < ApplicationRecord
  belongs_to :giver
  has_one :user, through: :giver
  has_many :requests
  has_many :requestors, through: :requests

  validates :headline, presence: true

  scope :group_by_location, -> { where(closed: false).order(state: :asc).order(city: :asc) }

  def city_state
    "#{city}, #{state}"
  end

  def self.open_offers
    Offer.where(closed: false).where(deleted: false)
  end
end
