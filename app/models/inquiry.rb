class Inquiry < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :message, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :email, presence: true ,length: {maximum: 105},format: {with: VALID_EMAIL_REGEX }
end
