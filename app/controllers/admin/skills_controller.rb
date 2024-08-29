class Admin::SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:edit,:update,:destroy]
  before_action :set_skills, only: [:index, :create, :edit, :update]

  def index
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      redirect_to admin_skills_path, notice: 'Skill was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end
  def edit
    render :index
  end

  def update
    if @skill.update(skill_params)
      redirect_to admin_skills_path, notice: 'Skill was successfully updated.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @skill.destroy
    redirect_to admin_skills_path, alert: 'Skill was successfully destroyed.'
  end

  # def destroy
  #   Skill.transaction do
  #     @skill.jobs.each do |job|
  #       RecalculateFitScoresJob.perform_later(job.id)
  #     end
  #     @skill.destroy!
  #     redirect_to admin_skills_path, alert: 'Skill was successfully destroyed.'
  #   end
  # end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:name)
  end

  def set_skills
    @skills = Skill.paginate(page: params[:page], per_page: 10)
  end

end
