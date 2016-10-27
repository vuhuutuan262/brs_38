class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_review
  before_action :find_comment, except: [:new, :create]
  before_action :valid_user, only: [:edit, :update, :destroy]

  def index
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build comment_params
    @comment.review_rate_id = @review.id
    if @comment.save
      reset_form_comment
      respond_to do |format|
        format.html {redirect_to book_review_rate_path @review.book, @review}
        format.js
      end
    else
      render :new
    end

  end

  def edit
    respond_to do |format|
      format.html {redirect_to book_review_rate_path @review.book, @review}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      reset_form_comment
      respond_to do |format|
        format.html {redirect_to book_review_rate_path @review.book, @review}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      format.html {redirect_to book_review_rate_path @review.book, @review}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def find_review
    @review = ReviewRate.find_by id: params[:review_rate_id]
    if @review.nil?
      redirect_to root_path
      flash[:danger] = t "review.comment.find_review_fail"
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    if @comment.nil?
      redirect_to book_path @review.book
      flash[:danger] = t "review.comment.find_comment"
    end
  end

  def reset_form_comment
    @comment = current_user.comments.build
  end

  def valid_user
    unless @comment.user == current_user
      redirect_to book_review_rate_path @review.book, @review
    end
  end

end
