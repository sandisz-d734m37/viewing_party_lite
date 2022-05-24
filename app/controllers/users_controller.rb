class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def login
  end

  def login_user
    user = User.find_by(email: params[:email])
    if !user.nil? && user.authenticate(params[:password])
      redirect_to("/users/#{user.id}")
    else
      redirect_to("/login")
      flash[:invalid_password] = "Invalid email or password"
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
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
