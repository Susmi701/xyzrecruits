module JobsFilters
  extend ActiveSupport::Concern

  private

  def apply_filters(jobs)
    jobs = filter_by_skill(jobs)
    jobs = filter_by_category(jobs)
    jobs = filter_by_status(jobs)
    jobs = filter_by_search(jobs)
    jobs
  end

  def filter_by_skill(jobs)
    return jobs unless params[:skill_id].present?

    jobs.joins(:skills).where(skills: { id: params[:skill_id] })
  end

  def filter_by_category(jobs)
    return jobs unless params[:category_id].present?

    jobs.where(category_id: params[:category_id])
  end

  def filter_by_status(jobs)
    return jobs unless params[:status].present?

    jobs.where(status: params[:status])
  end

  def filter_by_search(jobs)
    return jobs unless params[:search].present?

    jobs.where("title LIKE ?", "%#{params[:search]}%")
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
