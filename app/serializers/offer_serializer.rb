class OfferSerializer < ActiveModel::Serializer
  attributes :id, :giver_id, :headline, :city, :state, :availability, :closed, :deleted, :created_at
  has_many :requests, serializer: RequestSerializer
end
