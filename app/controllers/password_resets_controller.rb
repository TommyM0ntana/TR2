class PasswordResetsController < ApplicationController
  
  before_action :get_user,   only: [:edit, :update] 

  before_action :valid_user, only: [:edit, :update]

  before_action :check_expiration, only: [:edit, :update]      # Case (1)


  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      #self.reset_token = User.new_token
      #update_attribute(:reset_digest,  User.digest(reset_token))
      #update_attribute(:reset_sent_at, Time.zone.now)
      @user.send_password_reset_email
      #UserMailer.password_reset(self).deliver_now
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?                  # Case (3)
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update(user_params)                     # Case (4)
      reset_session
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'                                     # Case (2)
    end
  end

  private
  

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    if !(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      #reset_sent_at < 2.hours.ago
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_url
    end
  end



end
