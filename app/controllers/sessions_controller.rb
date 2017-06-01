class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: param[:session][:email]).downcase
    if user && user.authenticate(params[:session][:password])
      # something
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
