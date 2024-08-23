class Admin::SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:destroy]

  def index
    @skills = Skill.paginate(page: params[:page], per_page: 10)
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      redirect_to admin_skills_path, notice: 'Skill was successfully created.'
    else
      @skills = Skill.paginate(page: params[:page], per_page: 10)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @skill.destroy
    redirect_to admin_skills_path, notice: 'Skill was successfully destroyed.'
  end

  private

  def set_skill
    @skill = Skill.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
