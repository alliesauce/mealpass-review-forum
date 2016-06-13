class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review added!"
      redirect_to :back
    else
      redirect_to restaurant_url
    end
  end

  def destroy
  end

  private

    def review_params
      params.require(:review).permit(:title, :content, :meal_id, :user_id)
    end
  end
