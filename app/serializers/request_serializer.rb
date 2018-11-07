class RequestSerializer < ActiveModel::Serializer
  attributes :id, :offer_id, :requestor_id, :message, :requestor_email, :requestor_phone, :completed_giver, :completed_requestor, :created_at
end
