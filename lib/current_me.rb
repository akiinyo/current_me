require "current_me/version"
require File.join(File.dirname(__FILE__), 'current_me', 'railtie') if defined?(Rails::Railtie)

module CurrentMe
  extend ActiveSupport::Concern

  included do
    helper_method :me, :me?
  end

  def me
    if !request.ssl? || cookies.signed[:secure_me] == "secure\##{session[:me]}"
      @me ||= User.find(session[:me]) if session[:me]
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

    if user
      session[:me] = user.id
      cookies.signed[:secure_me] = {secure: true, value: "secure\##{user.id}"}
    end
    @me = user
  end

  def bye
    self.me = nil
    cookies.delete :secure_me
  end

  def come_from
    session[:come_from]
  end
end
