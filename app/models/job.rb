class Job < ApplicationRecord
  belongs_to :category
  has_many :job_skills,dependent: :destroy
  has_many :skills, through: :job_skills
  has_many :applications, dependent: :destroy
  enum job_type: {
    full_time: 0,
    part_time: 1,
    contract: 2,
    temporary: 3,
    internship: 4
  }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :experience_required,presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :closing_date, presence: true
  validate :closing_date_validity , if: -> { status == true }

  scope :active, -> { where(status: true) }

  private

  def closing_date_validity
    if closing_date.present? && closing_date < Date.today
      errors.add(:closing_date, 'must be today or a future date.')
    end
  end
  
end
