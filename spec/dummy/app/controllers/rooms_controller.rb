class RoomsController < ApplicationController
  before_filter do |c|
    c.me!(root_url)
  end

  def index
  end
end
