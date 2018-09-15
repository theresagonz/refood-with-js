class Giver < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :receivers, through: :offers
end
