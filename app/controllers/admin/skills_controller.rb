class Admin::SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill, only: [:edit,:update,:destroy]
  before_action :set_skills, only: [:index, :create, :edit, :update]

  def index
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    respond_to do |format|
      if @skill.save
        format.html { redirect_to admin_skills_path, notice: 'Skill was successfully created.' }
        format.turbo_stream { flash.now[:notice] = "Skill was successfully created." }
        else
          format.html { render :index, status: :unprocessable_entity }
          # format.turbo_stream { 
          #   render turbo_stream: turbo_stream.update("new_skill", partial: "form", 
          #           status: :unprocessable_entity, locals: { skill: @skill })
          # }
      end
    end
  end 

  def edit
    respond_to do |format|
      format.html { render :index }
      format.turbo_stream { 
        render turbo_stream: turbo_stream.update("new_skill", partial: "form", locals: { skill: @skill})
      }
    end
  end

  def update
    respond_to do |format|
      if @skill.update(skill_params)
          format.html { redirect_to admin_skills_path, notice: 'Skill was successfully updated.'}
          format.turbo_stream { flash.now[:notice] = "Skill was successfully updated." }
        
      else
        format.html { render :index, status: :unprocessable_entity }
        # format.turbo_stream { 
        #   render turbo_stream: turbo_stream.update("new_skill", partial: "form",
        #         status: :unprocessable_entity, locals: { skill: @skill})
        # }
      end
    end
  end


  def destroy
    @skill.destroy
    respond_to do |format|
      format.html { redirect_to admin_skills_path, alert: 'Skill was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = "Skill was successfully destroyed." }
    end
  end

 

  private

  def set_skill
    @skill = Skill.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to jobs_path, alert: 'Skill not found'
  end

  def skill_params
    params.require(:skill).permit(:name)
  end

  def set_skills
    @skills = Skill.paginate(page: params[:page], per_page: 10)
  end

end
