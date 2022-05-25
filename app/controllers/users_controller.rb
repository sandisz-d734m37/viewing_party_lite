class UsersController < ApplicationController
  def show
    if params[:user_id]
      @user = User.find(params[:user_id])
    elsif current_user
      @user = User.find(session[:user_id])
    else
      redirect_to '/'
      flash[:not_logged_in] = "You must log in or register to visit the dashboard"
    end
  end

  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:invalid_password] = user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
