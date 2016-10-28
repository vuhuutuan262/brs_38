class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :find_book, only: :show
  before_action :load_categories, only: :index

  def index
    @books = Book.search(params[:search]).
      order_desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    @reviews = @book.review_rates.desc.paginate page: params[:page],
      per_page: Settings.per_page
  end

  private
  def find_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      redirect_to books_path
      flash[:danger] = t "book_controller.book_blank"
    end
  end

  def load_categories
    @categories = Category.all
    if @categories.blank?
      flash[:danger] = t "categories.controller."
    end
  end
end
