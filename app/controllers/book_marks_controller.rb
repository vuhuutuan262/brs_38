class BookMarksController < ApplicationController
  before_action :logged_in_user
  before_action :load_mark, only: [:edit, :update]
  before_action :load_book, only: [:create, :edit, :update]
  before_action :mark_book, only: [:create, :edit, :update]

  def create
    @user_book = @book.book_marks.build marks_params
    if @user_book.save
      flash[:success] = t "user_book.create.success"
    else
      flash[:success] = t "user_book.create.not_success"
    end
    redirect_to @book
  end

  def edit
  end

  def update
    if @user_book.update_attributes marks_params
      flash[:success] = t "user_book.create.success"
    end
    redirect_to @book
  end

  private
  def marks_params
    params.require(:book_mark).permit :user_id, :book_id, :mark_type
  end

  def load_mark
    @user_book = BookMark.find_by id: params[:id]
    if @user_book.nil?
      flash[:danger] = t "book_controller.book_blank"
      redirect_to books_path
    end
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      flash[:danger] = t "book_controller.book_blank"
      redirect_to books_path
    end
  end

  def mark_book
    @mark_books = BookMark.mark_types.
      map {|key, value| [t("user_book.mark.#{key}"), key]}
  end
end
