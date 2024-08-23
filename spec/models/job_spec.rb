require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:job_skills).dependent(:destroy) }
    it { should have_many(:skills).through(:job_skills) }
    it { should have_many(:applications).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(100) }
    it { should validate_presence_of(:description) }
    #it { should validate_inclusion_of(:status).in_array([true, false]) }
    it { should validate_presence_of(:experience_required) }
    it { should validate_numericality_of(:experience_required).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:location) }
    it { should validate_length_of(:location).is_at_most(255) }
    it { should validate_presence_of(:closing_date) }
  end

  describe 'custom validations' do
    context 'when status is true' do
      it 'validates closing_date is today or in the future' do
        job = build(:job, status: true, closing_date: 1.day.ago)
        expect(job).to_not be_valid
        expect(job.errors[:closing_date]).to include('must be today or a future date.')
      end

      it 'allows closing_date to be today or in the future' do
        job = build(:job, status: true, closing_date: Date.today)
        expect(job).to be_valid
        job.closing_date = 1.day.from_now
        expect(job).to be_valid
      end
    end

    context 'when status is false' do
      it 'does not validate closing_date' do
        job = build(:job, status: false, closing_date: 1.day.ago)
        expect(job).to be_valid
      end
    end
  end

  describe 'scopes' do
    describe '.active' do
      it 'returns only jobs with status true' do
        active_job = create(:job, status: true)
        inactive_job = create(:job, status: false)
        expect(Job.active).to include(active_job)
        expect(Job.active).to_not include(inactive_job)
      end
    end
  end
end
