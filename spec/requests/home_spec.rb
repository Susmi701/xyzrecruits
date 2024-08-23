require 'rails_helper'

RSpec.describe "Homes", type: :request do
  before do
    create(:contact)
    create(:page_content)
  end

  describe "GET #index" do
    let!(:job1) { create(:job) }
    let!(:job2) { create(:job) }
    let!(:job3) { create(:job) }
    let!(:inactive_job) { create(:job, status: false) }

    before { get root_path }

    it "assigns the most recent active jobs to @jobs" do
      expect(assigns(:jobs)).to match_array([job3, job2, job1])
    end

    it "limits the jobs to 3" do
      expect(assigns(:jobs).size).to eq(3)
    end

    it "does not include inactive jobs" do
      expect(assigns(:jobs)).not_to include(inactive_job)
    end

    it "orders the jobs by created_at descending" do
      expect(assigns(:jobs)).to eq([job3, job2, job1])
    end

    it_behaves_like "a response with template", :index
  end

  describe "GET #about" do
    before{get about_path}
    it_behaves_like "a response with template", :about
  end

  describe "GET #contact" do
    let!(:contact) { create(:contact) }

    before { get contact_path }

    it "initializes a new inquiry as @inquiry" do
      expect(assigns(:inquiry)).to be_a_new(Inquiry)
    end

    it_behaves_like "a response with template", :contact
  end
end
