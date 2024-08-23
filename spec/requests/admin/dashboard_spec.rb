require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  let(:admin) { create(:user, :admin) } 
  let!(:active_jobs) { create_list(:job, 3, status: true) }
  let!(:inactive_job) { create(:job, status: false) }
  let!(:under_review_application) { create(:application, status: :under_review,job: active_jobs.first) }
  let!(:shortlisted_application) { create(:application, status: :shortlisted,job: active_jobs.second) }
  let!(:rejected_application) { create(:application, status: :rejected,job: active_jobs.last) }
  let!(:inquiries) { create_list(:inquiry, 2) }

  before do
    sign_in admin
    get admin_root_path
  end

  describe 'GET #index' do
    it 'assigns the correct counts and latest records' do
      expect(assigns(:active_jobs)).to eq(3)
      expect(assigns(:inactive_jobs)).to eq(1)
      expect(assigns(:under_review_applications)).to eq(1)
      expect(assigns(:shortlisted_applications)).to eq(1)
      expect(assigns(:rejected_applications)).to eq(1)
      expect(assigns(:inquiries)).to eq(2)
      expect(assigns(:latest_closing_jobs)).to match_array(active_jobs.sort_by(&:closing_date).first(3))
      expect(assigns(:latest_inquiries)).to match_array(inquiries.sort_by(&:created_at).reverse.first(3))
    end

    it_behaves_like "a response with template",:index
  end
end
