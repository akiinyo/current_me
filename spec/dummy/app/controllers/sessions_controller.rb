class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user
      self.me =  user
      redirect_to come_from || user
    else
      render 'new'
    end
  end

  def destroy
    bye
    redirect_to root_path
  end
end
