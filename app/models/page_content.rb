class PageContent < ApplicationRecord
  has_one_attached :home_img
  has_one_attached :ceo_img
  validates :home_header, :mission, :vision, :about_header, :about_us,:history, :ceo, :contact_header, presence: true
  validates :mission, :vision, :history, :about_us, length: { minimum: 255 }
end
