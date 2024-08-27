class PageContent < ApplicationRecord
  has_one_attached :home_img
  has_one_attached :ceo_img
  validates :home_header, :about_header, :ceo, :contact_header, presence: true, length: { minimum: 3 }
  validates :mission, :vision, :history, :about_us, presence: true, length: { minimum: 255 }
  validate :home_img_must_be_an_image
  validate :ceo_img_must_be_an_image

  private

  def image_validation(image, name)
    return unless image.attached?

    unless image.content_type.in?(%w(image/png image/jpg image/jpeg))
      errors.add(name, 'must be a PNG, JPG, or JPEG image')
    end

    if image.byte_size > 10.megabytes
      errors.add(name, 'should be less than 10MB')
    end
  end

  def ceo_img_must_be_an_image
    image_validation(ceo_img, :ceo_img)
  end

  def home_img_must_be_an_image
    image_validation(home_img, :home_img)
  end

end
