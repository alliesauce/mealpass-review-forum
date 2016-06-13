 class RestaurantsController < ApplicationController
  before_action :admin_user, only: [:edit, :update, :destroy]

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "Restaurant added!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @restaurants = Restaurant.paginate(:page => params[:page], :per_page => 10).order(:name)
    # if params[:search]
    #   @restaurants = Restaurant.search(params[:search])
    # else
    #   @restaurants
    # end

  end

  def destroy
    Restaurant.find(params[:id]).destroy
    flash[:success] = "Restaurant deleted"
    redirect_to restaurants_url
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @meals = @restaurant.meals.paginate(page: params[:page])
    @meal = @restaurant.meals.build if logged_in?
    # debugger
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    if @restaurant.update_attributes(restaurant_params)
      flash[:success] = "Restaurant updated"
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :raw_address, :google_map_url, :lat, :lng)
  end

  def user
    current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

end
