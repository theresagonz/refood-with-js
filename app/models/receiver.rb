class Receiver < ApplicationRecord
  belongs_to :user
  has_many :offers
  has_many :givers, through: :offers
end
