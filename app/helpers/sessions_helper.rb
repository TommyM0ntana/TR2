module SessionsHelper

  #Logs in the given user and create the session
  def log_in(user)
    session[:user_id] = user.id
  end

  #Remember a user in a permanent session as permanent cookie
  def remember(user)
    user.remember
    #create a enctypted permament cookies corris. on the user's id
    cookies.permanent.encrypted[:user_id] = user.id
    #store the remember token as permanent cookies on the browser
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  # def current_user
  #   if (user_id = session[:user_id])
  #     @current_user ||= User.find_by(id: user_id)
  #   elsif (user_id = cookies.encrypted[:user_id])
  #     user = User.find_by(id: user_id)
  #     if user && user.authenticated?(cookies[:remember_token])
  #       log_in user
  #       @current_user = user
  #     end
  #   end
  # end

# Returns the user corresponding to the remember token cookie.
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.encrypted[:user_id]
      user = User.find_by(id: cookies.encrypted[:user_id])
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  #returns true if the user is logged in, false otherwise
  def logged_in?
     !current_user.nil?
  end

  #Forget/delete a persistent session,the opposite of the remember(user) method
def forget(user)
  user.forget
  cookies.delete(:user_id)
  cookies.delete(:remember_token)
end

#logs him out delete the session(user_id) and the remember token
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  #Store the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_user?(user)
    user == current_user  
  end
  
end
