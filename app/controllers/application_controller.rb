class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def start
    render html: 'Hello there, this is currently running...'
  end
end
