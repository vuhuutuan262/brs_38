class Admin::CategoriesController < ApplicationController
  before_action :logged_as_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate page: params[:page], 
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.flash.category_create"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.flash.category_update"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controllers.flash.category_destroy"
    else
      flash[:danger] = t "controllers.flash.category_error"
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit :category_name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      redirect_to root_path
      flash[:danger] = t "admin.book.find_category"
    end
  end
end
