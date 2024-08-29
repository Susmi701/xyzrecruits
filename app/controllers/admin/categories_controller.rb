class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit,:update,:destroy]
  before_action :set_categories, only: [:index, :create, :edit, :update]

  def index
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    render :index
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
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

  def set_categories
    @categories=Category.paginate(page: params[:page], per_page: 10)
  end

end
