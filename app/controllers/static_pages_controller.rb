class StaticPagesController < ApplicationController
  #before_action :logged_in?, only: [:home]

  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page] )
    end
  end

  def help
  end

  def about
  end

  def contacts
  end
  
end
