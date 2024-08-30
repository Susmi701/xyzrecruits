 # def destroy
  #   Skill.transaction do
  #     @skill.jobs.each do |job|
  #       RecalculateFitScoresJob.perform_later(job.id)
  #     end
  #     @skill.destroy!
  #     redirect_to admin_skills_path, alert: 'Skill was successfully destroyed.'
  #   end
  # end


  class RecalculateFitScoresJob < ApplicationJob
  queue_as :default

  def perform(job_id)
    job = Job.find(job_id)
    job.applications.find_each do |application|
      application.update(fit_score: ApplicationFitScoreCalculator.new(application).calculate)
    end
  end
end