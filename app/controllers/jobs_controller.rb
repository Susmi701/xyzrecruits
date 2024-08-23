class JobsController < ApplicationController
  before_action :set_job_and_ensure_active, only: [:show, :apply, :submit_application]
  before_action :set_common_data, only: [:index]

  def index
    @jobs = Job.active.includes(:skills, :category).order(sort_order)
    apply_filters
    @jobs = @jobs.paginate(page: params[:page], per_page: 8)
  end

  def show
  end

  def apply
    @application = @job.applications.build
  end

  def submit_application
    @application = @job.applications.build(application_params)

    if @application.save
      ApplicationMailer.application_received(@application).deliver_later
      redirect_to confirm_job_path, notice: 'Your application has been submitted!'
    else
      render :apply, status: :unprocessable_entity
    end
  end

  def confirm
  end

  private

  def set_job_and_ensure_active
    @job = Job.find_by(id: params[:id])
    redirect_to jobs_path, alert: 'Job not found or inactive' unless @job&.status
  end

  def set_common_data
    @skills ||= Skill.all
    @categories ||= Category.all
  end

  def application_params
    params.require(:application).permit(:name, :email, :experience, :resume, skill_ids: [])
  end

  def apply_filters
    @jobs = @jobs.joins(:skills).where(skills: { id: params[:skill_id] }) if params[:skill_id].present?
    @jobs = @jobs.where(category_id: params[:category_id]) if params[:category_id].present?
    @jobs = @jobs.where("title LIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  def sort_order
    case params[:sort_by]
    when "closing_date_asc" then { closing_date: :asc }
    when "closing_date_desc" then { closing_date: :desc }
    when "created_at_asc" then { created_at: :asc }
    when "created_at_desc" then { created_at: :desc }
    else { created_at: :desc }
    end
  end

end
