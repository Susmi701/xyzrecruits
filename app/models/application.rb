class Application < ApplicationRecord
  belongs_to :job
  has_one_attached :resume
  has_many :application_skills, dependent: :destroy
  has_many :skills, through: :application_skills

  enum status: { under_review: 0, rejected: 1, shortlisted: 2 }
  after_validation :calculate_fit_score, on: :create
  
  before_save { self.email = email.downcase if email.present? }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :resume, presence: true
  validates :experience,presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :email, presence: true, length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { scope: :job_id, message: "You have already submitted an application for this job." }

  validate :resume_is_pdf_and_not_too_large

  private

  def resume_is_pdf_and_not_too_large
    return unless resume.attached?

    unless resume.content_type == 'application/pdf'
      errors.add(:resume, 'must be a PDF')
    end

    if resume.byte_size > 10.megabytes
      errors.add(:resume, 'should be less than 10MB')
    end
  end

  def calculate_fit_score
    return unless job.present? 
    self.fit_score = (skill_score * 0.7) + (experience_score * 0.3)
  end

  def skill_score
    job_skill_ids = job.skills.pluck(:id)
    applicant_skill_ids = skills.map(&:id)
    common_skills_count = (job_skill_ids & applicant_skill_ids).count
    total_skills_count = job_skill_ids.count
    total_skills_count.zero? ? 100 : (common_skills_count.to_f / total_skills_count) * 100
  end

  def experience_score
    required_experience = job.experience_required
    applicant_experience = experience || 0
    return 0 unless required_experience.present?
    if applicant_experience >= required_experience
      100
    else
      (experience.to_f / required_experience * 100).round(2)
    end
  end
end
