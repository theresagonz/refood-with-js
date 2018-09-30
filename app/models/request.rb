class Request < ApplicationRecord
  belongs_to :requestor
  belongs_to :offer
  has_one :user, through: :requestor
  has_one :giver, through: :offer
  has_one :comment

  validates :message, presence: true
  validate :email_or_phone

  private

    def email_or_phone
      if requestor_phone.blank? && requestor_email.blank?
        errors.add(:base, "Please provide an email address or password")
      end
    end
end
