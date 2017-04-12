class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hola
    render html: '¡Hola, Mundo!'
  end

  def hello
    render html: 'Hello, World!'
  end

  def goodbye
    render html: 'See you around sometime, then...'
  end
end
