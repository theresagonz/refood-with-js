class Giver < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :requests, through: :offers
  has_many :comments
  has_many :requestors, through: :comments
end
