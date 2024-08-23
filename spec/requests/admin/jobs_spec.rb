require 'rails_helper'

RSpec.describe "Admin::Jobs", type: :request do
  let(:admin) { create(:user, role: 1) }
  let(:job) { create(:job) }
  let(:valid_attributes) { attributes_for(:job).merge(
    category_id: create(:category).id,
    skill_ids: create_list(:skill, 3).map(&:id)
  )  }

  before { sign_in admin }

  describe 'GET #index' do
    context 'it' do
      let!(:jobs) { create_list(:job, 3) }

      it "renders the index template" do
        get admin_jobs_path
        expect(response).to render_template(:index)
        expect(assigns(:jobs)).to match_array(jobs) 
      end
    end
  
    context 'with filters' do
      let!(:filtered_job_by_skill) { create(:job, skills: [create(:skill)]) }
      let!(:filtered_job_by_category) { create(:job, category: create(:category)) }
      it 'filters by skill correctly' do
        get admin_jobs_path(skill_id: filtered_job_by_skill.skills.first.id)
        expect(assigns(:jobs)).to contain_exactly(filtered_job_by_skill)
      end

      it 'filters by category correctly' do
        get admin_jobs_path(category_id: filtered_job_by_category.category.id)
        expect(assigns(:jobs)).to contain_exactly(filtered_job_by_category)
      end
    end

    context 'sort ' do
      let!(:older_job) {create(:job, created_at: 1.day.ago,closing_date: 1.week.from_now )}
      let!(:newer_job) {create(:job, created_at: 1.hour.ago,closing_date: 1.day.from_now )}
  
      it 'sorts jobs by created_at_asc' do
        get admin_jobs_path, params: { sort_by: 'created_at_asc' }
        expect(assigns(:jobs).to_a).to eq([older_job, newer_job])
      end
      it 'sorts jobs by created_at_desc' do
        get admin_jobs_path, params: { sort_by: 'created_at_desc' }
        expect(assigns(:jobs).to_a).to eq([newer_job,older_job])
      end
      it 'sorts jobs by closing_date_desc' do
        get admin_jobs_path, params: { sort_by: 'closing_date_asc' }
        expect(assigns(:jobs).to_a).to eq([newer_job,older_job])
      end
      it 'sorts jobs by closing_date_asc' do
        get admin_jobs_path, params: { sort_by: 'closing_date_desc' }
        expect(assigns(:jobs).to_a).to eq([older_job, newer_job])
      end
    end
    
  end

  describe 'GET #show' do
  context 'it' do
    let!(:applications) { create_list(:application, 10, job: job) }
    it 'returns a success response and paginates applications' do
      get admin_job_path(job)
      expect(response).to be_successful
      expect(assigns(:applications).count).to eq(10)
    end
  end

    context '#filter_and_sort_applications' do
      let!(:application1) { create(:application, job: job, fit_score: 80, created_at: 1.day.ago, name: 'Alice') }
      let!(:application2) { create(:application, job: job, fit_score: 90, created_at: 2.days.ago, name: 'Bob') }
      let!(:application3) { create(:application, job: job, fit_score: 70, created_at: 3.days.ago, name: 'Charlie') }

      # it 'sorts by fit score descending' do
      #   get admin_job_path(job), params: { sort_by: 'fit-score-desc' }
      #   expect(assigns(:applications).map(&:fit_score)).to eq([90, 80, 70])
      # end

      # it 'sorts by fit score ascending' do
      #   get admin_job_path(job), params: { sort_by: 'fit-score-asc' }
      #   expect(assigns(:applications).map(&:fit_score)).to eq([70, 80, 90])
      # end
      context 'by created_at' do
        it 'sorts by date ascending' do
          get admin_job_path(job), params: { sort_by: 'date-asc' }
          expect(assigns(:applications).map(&:created_at).map(&:to_date)).to eq([3.days.ago.to_date, 2.days.ago.to_date, 1.day.ago.to_date])
        end

        it 'sorts by date descending' do
          get admin_job_path(job), params: { sort_by: 'date-desc' }
          expect(assigns(:applications).map(&:created_at).map(&:to_date)).to eq([1.day.ago.to_date, 2.days.ago.to_date, 3.days.ago.to_date])
        end
      end
    end
  end

  describe "GET #new" do
    it "assigns a new job to @job" do
      get new_admin_job_path
      expect(assigns(:job)).to be_a_new(Job)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Job' do
        expect {
          post admin_jobs_path, params: { job: valid_attributes }
        }.to change(Job, :count).by(1)
      end
      
      it 'redirects to the jobs index' do
        post admin_jobs_path, params: { job: valid_attributes }
        expect(response).to redirect_to(admin_jobs_path)
      end
    end

    context 'with invalid parameters' do
      before{post admin_jobs_path, params: { job: attributes_for(:job, title: nil) }}
      it 'does not create a new Job' do
       expect { subject }.not_to change(Job, :count)
      end

      it_behaves_like "a response with template", :new
      it_behaves_like "an unprocessable_entity"
    end
  end

  describe "GET #edit" do
    it "assigns the requested job to @job" do
      get edit_admin_job_path(job)
      expect(assigns(:job)).to eq(job)
    end
  end

 describe 'PATCH #update' do
  context 'with valid parameters' do
    before{patch admin_job_path(job), params: { job: { title: 'New Title' } }}
    it 'updates the requested job' do
      job.reload
      expect(job.title).to eq('New Title')
    end

    it 'redirects to the jobs index' do
      expect(response).to redirect_to(admin_jobs_path)
    end
  end

  context 'with invalid parameters' do
    before{patch admin_job_path(job), params: { job: { title: nil } }}
    
    it 'does not update the job' do
      job.reload
      expect(job.title).not_to be_nil
    end

    it_behaves_like "a response with template", :edit
    it_behaves_like "an unprocessable_entity"
  end
  end

  describe 'DELETE #destroy' do
    let!(:job_to_delete) { create(:job) }
    it 'destroys the requested job' do
      expect {
        delete admin_job_path(job_to_delete)
      }.to change(Job, :count).by(-1)
    end

    it 'redirects to the jobs list' do
      delete admin_job_path(job)
      expect(response).to redirect_to(admin_jobs_path)
    end
  end

  describe 'authorization' do
    let(:user) { create(:user) }
    before do
      sign_in user
      delete admin_job_path(job)
  end
    it_behaves_like "admin access required"
  end

end
