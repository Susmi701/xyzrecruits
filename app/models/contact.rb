class Contact < ApplicationRecord
  validates :address, :phone, :email, :website, presence: true
  validates :email,length: {maximum: 105},format: {with: VALID_EMAIL_REGEX } 
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }
  validates :address, length: { maximum: 255 }
  validates :phone, length: { maximum: 13 }
  validates :email, length: { maximum: 255 }
  validates :website, length: { maximum: 255 }
end
