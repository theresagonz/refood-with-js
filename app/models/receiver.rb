class Receiver < ApplicationRecord
  belongs_to :user
  has_many :offers_receivers
  has_many :offers, through: :offers_receivers
  has_many :givers, through: :offers
end
