class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to :back
    else
      redirect_to restaurant_url
    end
  end

  def destroy
  end

  private

    def review_params
      params.require(:comment).permit(:content, :user_id, :review_id)
    end
  end
