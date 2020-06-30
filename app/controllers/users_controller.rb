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
  end

  def update
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
      # log_in @user
      # flash[:success] = 'Welcome to my training app'
      # redirect_to @user
      #Loads up the mailer and deliver it
      UserMailer.account_activation(@user).deliver_now
      #send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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
  #unless da sostituire con il if not
  def logged_in_user
    if !logged_in?
      #se non loggato archiviami/salvami questo url in modo tale che una volta loggato,mi reindirizzi?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

# Confirms the correct user to let him edit and update his proper profile/data
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
  
  def admin_user
    redirect_to(root_url) if !current_user.admin?
  end

end
