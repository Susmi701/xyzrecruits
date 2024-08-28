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

  validates :title, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { in: 10..5000 }
  validates :status, inclusion: { in: [true, false] }
  validates :experience_required,presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :location, presence: true, length: { maximum: 255 }
  validates :closing_date, presence: true, comparison: { greater_than_or_equal_to: -> { Date.current } }, if: -> { status }

  after_update :recalculate_fit_scores, if: :relevant_changes?

  scope :active, -> { where(status: true) }

  private

  def recalculate_fit_scores
    RecalculateFitScoresJob.perform_later(id)
  end

  def relevant_changes?
    saved_change_to_experience_required? || job_skills_changed?
  end
  
  def job_skills_changed?
    job_skills.any? { |js| js.saved_change_to_attribute?(:skill_id) || js.saved_change_to_attribute?(:level) }
  end

end
