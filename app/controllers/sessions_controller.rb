class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # binding.pry
      session[:user_id] = user.id
      redirect_to "/"
      flash[:success] = "Welcome, #{user.email}"
    else
      flash[:invalid_password] = "Invalid email or password"
      render :new
    end
  end

end
