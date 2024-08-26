class PageContent < ApplicationRecord
  has_one_attached :home_img
  has_one_attached :ceo_img
  validates :home_header, :about_header, :ceo, :contact_header, presence: true, length: { minimum: 3 }
  validates :mission, :vision, :history, :about_us, presence: true, length: { minimum: 255 }
end
