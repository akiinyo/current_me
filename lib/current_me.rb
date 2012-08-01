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
    redirect_to url unless me?
  end

  def sign_in(user)
    self.me = user
  end

  def me=(user)
    reset_session

    if user
      session[:me] = user.id
      cookies.signed[:secure_me] = {secure: true, value: "secure\##{user.id}"}
    end
    @me = user
  end

  def sign_out
    self.me = nil
    cookies.delete :secure_me
  end
end
