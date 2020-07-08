class ApplicationController < ActionController::Base
  include SessionsHelper

  private
  
  #Before filters, confirm a logged-in-user
  def logged_in_user
    if !logged_in?
      #se non loggato archiviami/salvami questo url in modo tale che una volta loggato,mi reindirizzi?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

#returns true if the user is logged in, false otherwise
 def logged_in?
  !current_user.nil?
 end

end
