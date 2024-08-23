require 'rails_helper'

RSpec.describe "Jobs", type: :request do
  let(:job) { create(:job) }
  let(:skill) { create(:skill) }
  let(:category) { create(:category) }
  let(:application_attributes) { attributes_for(:application) }
  let(:invalid_application_attributes) { attributes_for(:application, name: nil) }

  before do
    create(:contact)
    create(:page_content)
  end

  describe "GET #index" do
    it "returns a success response and assigns jobs" do
      job
      get jobs_path
      expect(response).to be_successful
      expect(assigns(:jobs)).to include(job)
    end

    it "applies filters correctly" do
      matching_job = create(:job, skills: [skill], category: category, title: "Ruby Developer")
      create(:job)

      get jobs_path, params: { skill_id: skill.id, category_id: category.id, search: "Ruby" }

      expect(assigns(:jobs)).to include(matching_job)
      expect(assigns(:jobs)).not_to include(job)
    end

  end
  describe 'sort and filter job' do
    let!(:older_job) {create(:job, created_at: 1.day.ago,closing_date: 1.week.from_now )}
    let!(:newer_job) {create(:job, created_at: 1.hour.ago,closing_date: 1.day.from_now )}

    it 'sorts jobs by created_at_asc' do
      get jobs_path, params: { sort_by: 'created_at_asc' }
      expect(assigns(:jobs).to_a).to eq([older_job, newer_job])
    end
    it 'sorts jobs by created_at_desc' do
      get jobs_path, params: { sort_by: 'created_at_desc' }
      expect(assigns(:jobs).to_a).to eq([newer_job,older_job])
    end
    it 'sorts jobs by closing_date_desc' do
      get jobs_path, params: { sort_by: 'closing_date_asc' }
      expect(assigns(:jobs).to_a).to eq([newer_job,older_job])
    end
    it 'sorts jobs by closing_date_asc' do
      get jobs_path, params: { sort_by: 'closing_date_desc' }
      expect(assigns(:jobs).to_a).to eq([older_job, newer_job])
    end
  end

  describe "GET #show" do
    context "when job is active" do
      it "returns a success response" do
        get job_path(job)
        expect(response).to be_successful
      end
    end

    context "when job is inactive" do
      it "redirects to jobs index" do
        inactive_job = create(:job, status: false)
        get job_path(inactive_job)
        expect(response).to redirect_to(jobs_path)
      end
    end
  end

  describe "GET #apply" do
    it "returns a success response" do
      get apply_job_path(job)
      expect(response).to be_successful
    end
  end

  describe "POST #submit_application" do
    context "with valid params" do
      it "creates a new application and sends an email" do
        expect {
          post submit_application_job_path(job), params: { application: application_attributes }
        }.to change(Application, :count).by(1)
        expect(response).to redirect_to(confirm_job_path)
      end
    end

    context "with invalid params" do
      it "re-renders the apply template with errors" do
        post submit_application_job_path(job), params: { application: invalid_application_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #confirm" do
    it "returns a success response" do
      get confirm_job_path(job)
      expect(response).to be_successful
    end
  end
end
