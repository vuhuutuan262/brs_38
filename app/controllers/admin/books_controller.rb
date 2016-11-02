class Admin::BooksController < ApplicationController
  before_action :find_book, except: [:index, :new, :create]
  before_action :find_category

  def index
    @books = @category.books.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = @category.books.build book_params
    if @book.save
      redirect_to admin_category_books_path @category
      flash[:success] = t "book_controller.create_success"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      redirect_to admin_category_books_path @category
      flash[:success] = t "book_controller.update_success"
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "book_controller.destroy_success"
    else
      flash[:success] = t "book_controller.destroy_fail"
    end
    redirect_to admin_category_books_path @category
  end

  private
  def book_params
    params.require(:book).permit :category_id, :title, :author,
      :publish_date, :number_of_page, :description, :cover
  end

  def find_category
    @category = Category.find_by id: params[:category_id]
    if @category.nil?
      redirect_to admin_categories_path
      flash[:danger] = t "admin.book.find_category"
    end
  end

  def find_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      redirect_to admin_categories_path
      flash[:danger] = t "views.requests.edit.find_book_fail"
    end
  end
end
