class UpdateJobStatusJob < ApplicationJob
  queue_as :default

  def perform
    Job.where('closing_date <= ?', Time.current).where(status: true).update_all(status: false)
  end
end
