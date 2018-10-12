class Request < ApplicationRecord
  belongs_to :requestor
  belongs_to :offer
  has_one :user, through: :requestor
  has_one :giver, through: :offer

  validates :message, presence: true
  validate :email_or_phone


  # def self.recently_completed
  #   Request.where("completed_requestor = ?", true).or(Request.where("completed_giver = ?", true)).order(updated_at: :desc).limit(10)
  # end

  scope :recently_completed, -> { order(updated_at: :desc).where(completed_requestor: true).where(completed_giver: true) }
  
  private

    def email_or_phone
      if requestor_phone.blank? && requestor_email.blank?
        errors.add(:base, "Please provide an email address or password")
      end
    end
end
