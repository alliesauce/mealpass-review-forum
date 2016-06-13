class MealsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :admin_user, only: [:edit, :update, :destroy]

  def create
    @meal = current_user.meals.build(meal_params)
    if @meal.save
      flash[:success] = "Meal added!"
      redirect_to :back
    else
      redirect_to restaurant_url
    end
  end

  def show
    @meal = Meal.find(params[:id])
    @reviews = @meal.reviews.paginate(page: params[:page])
    # debugger
    @review = @meal.reviews.build if logged_in?
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:meal).permit(:description)
    end

end
