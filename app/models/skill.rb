class Skill < ApplicationRecord
  has_many :application_skills, dependent: :destroy
  has_many :applications, through: :application_skills
  has_many :job_skills, dependent: :destroy
  has_many :jobs, through: :job_skills

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }

  # before_destroy :store_affected_job_ids
  # after_destroy :recalculate_affected_applications

  # private

  # attr_accessor :affected_job_ids

  # def store_affected_job_ids
  #   @affected_job_ids = jobs.pluck(:job_id)
  #   debugger
  # end

  # def recalculate_affected_applications
  #   return if @affected_job_ids.blank?
    
  #   self.jobs.find_each do |job|
  #     RecalculateFitScoresJob.perform_later(job.id)
  #   end
  # end

end
