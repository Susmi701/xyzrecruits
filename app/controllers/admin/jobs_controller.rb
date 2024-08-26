class Admin::JobsController < ApplicationController
  include JobsFilters

  before_action :authenticate_user!
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :set_common_data, only: [:index, :new, :edit]
  before_action :authorize_admin, only: [:destroy]

  def index
    @jobs = Job.includes(:skills, :category).order(sort_order)
    @jobs = apply_filters(@jobs)
    @jobs = @jobs.paginate(page: params[:page], per_page: 8)
  end

  def show
    @applications = filter_and_sort_applications(@job.applications)
                    .paginate(page: params[:page], per_page: 8)
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to admin_jobs_path, notice: 'Job created successfully.'
    else
      set_common_data
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path, notice: 'Job updated successfully.'
    else
      set_common_data
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to admin_jobs_path, notice: 'Job deleted successfully.'
  end

  private

  def set_job
    @job = Job.find_by(id: params[:id])
    redirect_to jobs_path, alert: 'Job not found' unless @job
  end

  def set_common_data
    @skills ||= Skill.all
    @categories ||= Category.all
  end

  def job_params
    params.require(:job).permit(:title, :description, :status, :category_id, 
                                :experience_required, :educational_qualification,
                                :location, :job_type, :closing_date, skill_ids: [])
  end

  def filter_and_sort_applications(applications)
    applications = applications.where(status: params[:status]) if params[:status].present?
    applications = applications.where('fit_score >= ?', params[:fit_score_min]) if params[:fit_score_min].present?
    applications = applications.where('fit_score <= ?', params[:fit_score_max]) if params[:fit_score_max].present?

    case params[:sort_by]
    when 'fit-score-desc' then applications.order(fit_score: :desc)
    when 'fit-score-asc' then applications.order(fit_score: :asc)
    when 'date-desc' then applications.order(created_at: :desc)
    when 'date-asc' then applications.order(created_at: :asc)
    else applications.order(fit_score: :desc)
    end
  end

  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user&.admin?
  end
end
