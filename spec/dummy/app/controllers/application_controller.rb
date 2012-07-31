class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate!
    session[:origin] = request.fullpath
    me! root_url
  end
end
