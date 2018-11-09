class OfferSerializer < ActiveModel::Serializer
  attributes :id, :giver_id, :headline, :description, :city, :state, :availability, :closed, :deleted, :time_ago_created, :created_date
  has_many :requests, serializer: RequestSerializer
end
