 # def destroy
  #   Skill.transaction do
  #     @skill.jobs.each do |job|
  #       RecalculateFitScoresJob.perform_later(job.id)
  #     end
  #     @skill.destroy!
  #     redirect_to admin_skills_path, alert: 'Skill was successfully destroyed.'
  #   end
  # end