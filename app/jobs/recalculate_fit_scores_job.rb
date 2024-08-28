class RecalculateFitScoresJob < ApplicationJob
  queue_as :default

  def perform(job_id)
    job = Job.find(job_id)
    job.applications.find_each do |application|
      application.update(fit_score: ApplicationFitScoreCalculator.new(application).calculate)
    end
  end
end