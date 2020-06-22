class UsersController < ApplicationController
  #Specify that only how's logged in can do this actions
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  #Specify that only the user it self can edit and update
  before_action :correct_user, only: [:edit, :update]
  #Specify that only admin users can delete 
  before_action :admin_user,     only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

  #Before filters,confirm a logged-in-user
  def logged_in_user
    unless logged_in?
      #se non logato archiviami/salvami questo url in modo tale che una volta logato proseguiremo la dove volevamo arrivare?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

# Confirms the correct user to let him edit and update his proper profile/data
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless @user && @user == current_user
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
