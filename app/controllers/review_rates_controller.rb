class ReviewRatesController < ApplicationController
  before_action :logged_in_user
  before_action :find_book
  before_action :find_review, except: [:new, :create]

  def new
    @review = ReviewRate.new
  end

  def create
    @review = current_user.review_rates.build review_params
    @review.book_id = @book.id
    if @review.save
      redirect_to book_path @book
      flash[:success] = t "review.controller.flash_success"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "book_controller.update_success"
      redirect_to book_path @book
    else
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "book_controller.destroy_success"
    else
      flash[:danger] = t "review.controller.destroy_fail"
    end
    redirect_to book_path @book
  end

  private
  def review_params
    params.require(:review_rate).permit :content, :number_rate_of_user, :book_id
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    if @book.nil?
      redirect_to categories_path
      flash[:danger] = t "views.requests.edit.find_book_fail"
    end
  end

  def find_review
    @review = ReviewRate.find_by id: params[:id]
    if @review.nil?
      redirect_to book_path @book
      flash[:danger] = t "review.controller.find_review_fail"
    end
  end
end
