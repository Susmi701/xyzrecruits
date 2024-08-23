require 'rails_helper'

RSpec.describe "Admin::Applications", type: :request do
  let(:user) { create(:user) }
  let(:job) { create(:job) }
  let(:application) { create(:application, job: job) }

  context 'when user is not signed in' do
    it_behaves_like "redirects to sign-in" do
      before {patch shortlist_admin_job_application_path(job,application)}
    end
    it_behaves_like "redirects to sign-in" do
      before { patch reject_admin_job_application_path(job,application)}
    end
  end

  context 'when user is signed in ' do
    before do
      sign_in user
    end

    describe 'PATCH #shortlist' do
      it 'shortlists the application' do
        patch shortlist_admin_job_application_path(job,application)
        expect(application.reload.status).to eq('shortlisted')
        expect(response).to redirect_to(admin_job_path(job))
        expect(flash[:notice]).to eq('Application has been shortlisted!')
      end

      it 'sends a shortlist email' do
        expect {
          patch shortlist_admin_job_application_path(job,application)
        }.to have_enqueued_job.on_queue('default')
      end
    end

    describe 'PATCH #reject' do
      it 'rejects the application' do
        patch reject_admin_job_application_path(job,application)
        expect(application.reload.status).to eq('rejected')
        expect(response).to redirect_to(admin_job_path(job))
        expect(flash[:notice]).to eq('Application has been rejected!')
      end
    end
  end
  
end
