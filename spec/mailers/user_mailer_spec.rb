require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:job) { create(:job) }
  let(:application) { create(:application, job: job, email: 'applicant@example.com') }

  describe '#shortlisted_email' do
    let(:mail) { UserMailer.shortlisted_email(application) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your Application has been Shortlisted ')
      expect(mail.to).to eq(['applicant@example.com'])
      expect(mail.from).to eq(['susmiels590@gmail.com'])
    end

  end

  describe '#application_received' do
    let(:mail) { UserMailer.application_received(application) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your application has been received')
      expect(mail.to).to eq(['applicant@example.com'])
      expect(mail.from).to eq(['susmiels590@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Your application has been received')
    end
  end
end
