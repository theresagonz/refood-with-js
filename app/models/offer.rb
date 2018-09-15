class Offer < ApplicationRecord
  belongs_to :giver
  has_many :offers_receivers
  has_many :receivers, through: :offers_receivers
end
