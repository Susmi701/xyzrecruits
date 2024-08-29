class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @active_jobs = Job.active.count
    @inactive_jobs = Job.where(status: 'false').count
    @under_review_applications = Application.where(status: :under_review).count
    @shortlisted_applications = Application.where(status: :shortlisted).count
    @rejected_applications = Application.where(status: :rejected).count
    @inquiries = Inquiry.count
    @latest_closing_jobs = Job.where(status: true).order(closing_date: :asc).limit(3).load_async
    @latest_inquiries = Inquiry.order(created_at: :desc).limit(3).load_async
  end
end
