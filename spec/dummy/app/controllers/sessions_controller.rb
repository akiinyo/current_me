class SessionsController < ApplicationController
  def new
  end

  def create
    origin = session[:origin]
    user = User.find_by_name(params[:name])
    if user
      sign_in user
      redirect_to origin || user
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
