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
      subject { patch shortlist_admin_job_application_path(job,application) }

      context 'when successful' do
        it 'updates the application status to shortlisted' do
          expect { subject }.to change { application.reload.status }.to('shortlisted')
        end

        it 'sends a shortlisted email' do
          expect { subject }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
        end

        it 'redirects to the job page with a success notice' do
          subject
          expect(response).to redirect_to(admin_job_path(job))
          expect(flash[:notice]).to eq('Application has been shortlisted!')
        end
      end

      context 'when unsuccessful' do
        before do
          allow_any_instance_of(Application).to receive(:update).and_return(false)
        end

        it 'redirects to the job page with an alert' do
          subject
          expect(response).to redirect_to(admin_job_path(job))
          expect(flash[:alert]).to eq('Failed to shortlist the application.')
        end
      end
    end
  
    describe 'PATCH #reject' do
      subject { patch reject_admin_job_application_path(job,application)}

      context 'when successful' do
        it 'updates the application status to rejected' do
          expect { subject }.to change { application.reload.status }.to('rejected')
        end

        it 'redirects to the job page with a success notice' do
          subject
          expect(response).to redirect_to(admin_job_path(job))
          expect(flash[:notice]).to eq('Application has been rejected!')
        end
      end

      context 'when unsuccessful' do
        before do
          allow_any_instance_of(Application).to receive(:update).and_return(false)
        end

        it 'redirects to the job page with an alert' do
          subject
          expect(response).to redirect_to(admin_job_path(job))
          expect(flash[:alert]).to eq('Failed to reject the application.')
        end
      end
    end

  end
end
