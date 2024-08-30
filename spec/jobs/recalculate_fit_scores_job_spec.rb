require 'rails_helper'

RSpec.describe RecalculateFitScoresJob, type: :job do
  let!(:job) { create(:job) }
  let!(:application_1) { create(:application, job: job, email: 'test1@example.com', fit_score: 50) }
  let!(:application_2) { create(:application, job: job, email: 'test2@example.com', fit_score: 60) }

  before do
    # Assuming ApplicationFitScoreCalculator returns a calculated fit score.
    allow_any_instance_of(ApplicationFitScoreCalculator).to receive(:calculate).and_return(80)
  end

  it 'recalculates fit scores for all applications associated with the job' do
    described_class.perform_now(job.id)

    expect(application_1.reload.fit_score).to eq(80)
    expect(application_2.reload.fit_score).to eq(80)
  end
end
