class Admin::ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job
  before_action :set_application

  def shortlist
    if @application.update(status: :shortlisted)
      ApplicationMailer.shortlisted_email(@application).deliver_later
      redirect_to admin_job_path(@job), notice: 'Application has been shortlisted!'
    else
      redirect_to admin_job_path(@job), alert: 'Failed to shortlist the application.'
    end
  end

  def reject
    if @application.update(status: :rejected)
      redirect_to admin_job_path(@job), notice: 'Application has been rejected!'
    else
      redirect_to admin_job_path(@job), alert: 'Failed to reject the application.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_application
    @application = @job.applications.find_by(id: params[:id])
    redirect_to admin_job_path(@job), alert: 'Application not found' unless @application
  end
end
