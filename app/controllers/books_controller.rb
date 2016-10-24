class BooksController < ApplicationController
  before_action :find_book, only: :show

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
end
