class Skill < ApplicationRecord
  has_many :application_skills, dependent: :destroy
  has_many :applications, through: :application_skills
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

  # before_destroy :recalculate_fit_scores

  # private

  
  # def recalculate_fit_scores
  #   debugger
  #   self.jobs.find_each do |job|
  #     RecalculateFitScoresJob.perform_later(job.id)
  #   end
  # end
end
