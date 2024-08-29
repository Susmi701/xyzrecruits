class UpdateJobStatusJob < ApplicationJob
  queue_as :default
  #retry_on AlwaysRetryException, attempts: :unlimited

  def perform
    Job.where('closing_date <= ?', Time.current).where(status: true).update_all(status: false)
  end
end
