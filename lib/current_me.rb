require "current_me/version"
require File.join(File.dirname(__FILE__), 'current_me', 'railtie') if defined?(Rails::Railtie)

module CurrentMe
  extend ActiveSupport::Concern

  included do
    helper_method :me, :me?
  end

  def me
    if secure_me?
      valid_me
    else
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
    current_me user
  end

  def secure_me=(user)
    current_me user
    cookies.signed[:secure_me] = {secure: true, value: "secure\##{user.id}"} if user
  end

  def bye
    if secure_me?
      self.secure_me = nil
      cookies.delete :secure_me
    else
      self.me = nil
    end
  end

  def come_from
    session[:come_from]
  end

  private

  def current_me(user)
    reset_session

    session[:me] = user.id if user
    @me = user
  end

  def secure_me?
    cookies.signed[:secure_me]
  end

  def valid_me
    if !request.ssl? || cookies.signed[:secure_me] == "secure\##{session[:me]}"
      @me ||= User.find(session[:me]) if session[:me]
    end
  end
end
