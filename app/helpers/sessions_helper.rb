module SessionsHelper
  #Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end
  
  #return the current logged-in user(if exist)
  def current_user
   if session[:user_id]
   @current_user ||= User.find_by(id: session[:user_id])
   end
  end

  #returns true if the user is logged in, false #otherwise
  def logged_in?
     !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end
  
end
