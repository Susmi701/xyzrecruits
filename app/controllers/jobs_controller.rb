class JobsController < ApplicationController
  include JobsFilters

  before_action :set_job,:ensure_active_job, only: [:show, :apply, :submit_application]
  before_action :set_common_data, only: [:index]
  

  def index
    @jobs = Job.active.includes(:skills, :category)
               .order(sort_order)
               .then { |jobs| apply_filters(jobs) }
               .paginate(page: params[:page], per_page: 8)
  end

  def show
  end

  def apply
    @application = @job.applications.build
  end

  def submit_application
    @application = @job.applications.build(application_params)

    if @application.save
      UserMailer.application_received(@application).deliver_later
      redirect_to confirm_job_path, notice: 'Your application has been submitted!'
    else
      render :apply, status: :unprocessable_entity
    end
  end

  def confirm
  end

  private

  def set_job
    @job = Job.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to jobs_path, alert: 'Job not found'
  end

  def ensure_active_job
    redirect_to jobs_path, alert: 'Job not found or inactive' unless @job&.status
  end

  def set_common_data
    @skills = Skill.all
    @categories = Category.all
  end

  def application_params
    params.require(:application).permit(:name, :email, :experience, :resume, skill_ids: [])
  end

end
