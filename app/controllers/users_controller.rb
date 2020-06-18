class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
   @users = User.all
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
   @user = User.find(params[:id])
   if @user.update(user_params)
    flash[:success] = 'Profile Updated'
    redirect_to @user 
   else
    render 'edit'
   end
  end

  def show
   @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to my training app'
      redirect_to @user
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

  #Before filters,confirm a logged-in-user
  def logged_in_user
    unless logged_in?
      #se non logato archiviami questo url in modo tale che una volta logato ti reindirizzero?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

# Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user == current_user
  end
  


end
