module JobsFilters
  extend ActiveSupport::Concern

  # included do
  #   before_action :set_common_data, only: [:index, :new, :edit]
  # end

  private

  def apply_filters(jobs)
    jobs = jobs.joins(:skills).where(skills: { id: params[:skill_id] }) if params[:skill_id].present?
    jobs = jobs.where(category_id: params[:category_id]) if params[:category_id].present?
    jobs = jobs.where(status: params[:status]) if params[:status].present?
    jobs = jobs.where("title LIKE ?", "%#{params[:search]}%") if params[:search].present?
    jobs
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
