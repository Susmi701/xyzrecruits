class Admin::PageContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_page_content, only: [:edit, :update]

  def edit
  end

  def update
    @page_content.home_img.purge if params[:page_content][:home_img].present?
    @page_content.ceo_img.purge if params[:page_content][:ceo_img].present?
    if @page_content.update(page_content_params)
      redirect_to edit_admin_page_contents_path(@page_content), notice: 'Page content was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_page_content
    @page_content = PageContent.first 
  end

  def page_content_params
    params.require(:page_content).permit(:home_header,:contact_header, :mission, :vision, :about_header, :about_us, :history, :ceo, :home_img, :ceo_img)
  end
  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user&.admin?
  end
end
