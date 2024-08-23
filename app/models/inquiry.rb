class Inquiry < ApplicationRecord
  validates :name, :message, presence: true
  validates :email, presence: true ,length: {maximum: 105},format: {with: VALID_EMAIL_REGEX }
end
