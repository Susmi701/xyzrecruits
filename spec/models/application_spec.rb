require 'rails_helper'

RSpec.describe Application, type: :model do
  let(:job) { create(:job) }
  let(:application) { build(:application, job: job) }

  describe 'associations' do
    it { should belong_to(:job) }
    it { should have_one_attached(:resume) }
    it { should have_many(:application_skills).dependent(:destroy) }
    it { should have_many(:skills).through(:application_skills) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:resume) }
    it { should validate_presence_of(:experience) }
    it { should validate_numericality_of(:experience).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:email).is_at_most(105) }
    it { should allow_value("test@example.com").for(:email) }
    it { should_not allow_value("test@example").for(:email) }
    it { should_not allow_value("test@.com").for(:email) }
    it { should_not allow_value("test@com").for(:email) }
    it { should_not allow_value("test.com").for(:email) }
   
    it 'validates uniqueness of email scoped to job_id' do
      create(:application, job: job, email: 'testuser1@gmail.com')
      expect(application).to_not be_valid
      expect(application.errors[:email]).to include("You have already submitted an application for this job.")
    end


    context 'resume validation' do

      it 'should be a PDF' do
        application.resume.attach(io: File.open('spec/fixtures/files/sample.txt'), filename: 'sample.txt', content_type: 'text/plain')
        expect(application).to_not be_valid
        expect(application.errors[:resume]).to include('must be a PDF')
      end

      it 'should not be larger than 10MB' do
        large_pdf = Tempfile.new(['large', '.pdf'])
        large_pdf.write("0" * 11.megabytes)
        large_pdf.rewind
        application.resume.attach(io: large_pdf, filename: 'large.pdf', content_type: 'application/pdf')
        expect(application).to_not be_valid
        expect(application.errors[:resume]).to include('should be less than 10MB')
        large_pdf.close
        large_pdf.unlink
      end
    end
  end

  describe '#calculate_fit_score' do
  let(:skill1) { create(:skill) }
  let(:skill2) { create(:skill, name: 'skill2') }

  before do
    job.skills << skill1 << skill2
  end

  context 'when applicant experience matches required experience' do
    before do
      application.skills << skill1
      application.experience = job.experience_required
      application.save
    end

    it 'calculates fit score based on skills and experience' do
      expected_skill_score = 50.0 
      expected_experience_score = 100.0
      expected_fit_score = (expected_skill_score * 0.7) + (expected_experience_score * 0.3)

      expect(application.fit_score).to eq(expected_fit_score)
    end
  end

  context 'when applicant experience is less than required experience' do
    before do
      application.skills << skill1
      application.experience = job.experience_required - 1
      application.save
    end

    it 'calculates fit score with lower experience score' do
      expected_skill_score = 50.0 
      expected_experience_score = ((application.experience.to_f / job.experience_required) * 100).round(2)
      expected_fit_score = (expected_skill_score * 0.7) + (expected_experience_score * 0.3)

      expect(application.fit_score).to eq(expected_fit_score)
    end
  end
  end
end
