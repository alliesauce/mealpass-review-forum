class UsersController < ApplicationController

  #this stops non logged in users from being able to access edit/update functions and also stops logged in users from modifying the accounts of anyone except themselves
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
        flash[:info] = "Please check your email to activate your account."
        redirect_to login_url
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 10).order(:username)
    # debugger
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(page: params[:page])
    @comments = @user.comments.paginate(page: params[:page])
    # debugger
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :about_me)
    end

end
