class ApplicationController < ActionController::Base
  def welcome
    render html: "Let's get started"
  end
end
