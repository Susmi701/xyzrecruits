require 'rails_helper'

RSpec.describe UpdateJobStatusJob, type: :job do
  describe '#perform' do
    let!(:active_past_job) { create(:job, closing_date: Date.today, status: true) }
    let!(:active_future_job) { create(:job, closing_date: 1.day.from_now, status: true) }
    let!(:inactive_past_job) { create(:job, closing_date: Date.today, status: false) }
    let!(:inactive_future_job) { create(:job, closing_date: 1.day.from_now, status: false) }

    it 'updates status to false for active jobs with closing date in the past' do
      expect {
        UpdateJobStatusJob.new.perform
      }.to change { active_past_job.reload.status }.from(true).to(false)
    end

    it 'does not update status for active jobs with future closing date' do
      expect {
        UpdateJobStatusJob.new.perform
      }.not_to change { active_future_job.reload.status }
    end

    it 'does not update status for inactive jobs' do
      expect {
        UpdateJobStatusJob.new.perform
      }.not_to change { inactive_past_job.reload.status }

    end
  end

end