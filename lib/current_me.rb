require "current_me/version"
require File.join(File.dirname(__FILE__), 'current_me', 'railtie') if defined?(Rails::Railtie)

module CurrentMe
  extend ActiveSupport::Concern

  included do
    helper_method :me, :me?
  end

  def me
    if id = session[:me]
      @me ||= User.find(id)
    end
  rescue ActiveRecord::RecordNotFound
    self.me = nil
  end

  def me?
    !!me
  end

  def me!(url)
    unless me?
      session[:come_from] = request.fullpath

      redirect_to url
    end
  end

  def me=(user)
    reset_session

    session[:me] = user.id if user
    @me = user
  end

  def bye
    self.me = nil
  end

  def come_from
    session[:come_from]
  end
end
