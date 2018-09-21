class Giver < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :requests, through: :offers
  has_many :requestors, through: :requests
  has_many :receivers, through: :offers
end
