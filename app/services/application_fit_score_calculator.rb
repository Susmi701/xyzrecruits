class ApplicationFitScoreCalculator
  def initialize(application)
    @application = application
  end

  def calculate
    skill_score = calculate_skill_score
    experience_score = calculate_experience_score
    (skill_score * 0.7) + (experience_score * 0.3)
  end

  private

  def calculate_skill_score
    job_skill_ids = @application.job.skills.pluck(:id)
    applicant_skill_ids = @application.skills.map(&:id)
    common_skills_count = (job_skill_ids & applicant_skill_ids).count
    total_skills_count = job_skill_ids.count
    total_skills_count.zero? ? 100 : (common_skills_count.to_f / total_skills_count) * 100
  end

  def calculate_experience_score
    required_experience = @application.job.experience_required
    applicant_experience = @application.experience || 0
    return 0 unless required_experience.present?
    applicant_experience >= required_experience ? 100 : (applicant_experience.to_f / required_experience * 100).round(2)
  end
end
