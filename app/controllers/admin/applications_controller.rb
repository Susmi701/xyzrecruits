class Admin::ApplicationsController < ApplicationController
  before_action :authenticate_user!

  def shortlist
    @job = Job.find(params[:job_id])
    @application = @job.applications.find(params[:id])
    @application.update(status: :shortlisted)
    ApplicationMailer.shortlisted_email(@application).deliver_later
    redirect_to admin_job_path(@job), notice: 'Application has been shortlisted!'
  end

  def reject
    @job = Job.find(params[:job_id])
    @application = @job.applications.find(params[:id])
    @application.update(status: :rejected)
    redirect_to admin_job_path(@job), notice: 'Application has been rejected!'
  end
end
