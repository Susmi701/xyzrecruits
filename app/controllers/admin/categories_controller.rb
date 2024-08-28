class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit,:update,:destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      @categories = Category.paginate(page: params[:page], per_page: 10)
      render :index, status: :unprocessable_entity
    end
  end
  def edit
    @categories = Category.paginate(page: params[:page], per_page: 10)
    render :index
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      @categories = Category.paginate(page: params[:page], per_page: 10)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.jobs.exists?
      redirect_to admin_categories_path, alert: 'Cannot delete category because it has associated jobs.'
    else
      @category.destroy
      redirect_to admin_categories_path, notice: 'Category was successfully destroyed.'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
