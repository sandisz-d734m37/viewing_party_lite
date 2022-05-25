class PartiesController < ApplicationController
  def new
    if current_user
      @movie = MovieFacade.details(params[:movie_id])
      @user = current_user
      @users = User.all
    else
      redirect_to "/users/#{params[:user_id]}/movies/#{params[:movie_id]}"
      flash[:not_registered] = "You must log in or register to create a viewing party"
    end
  end

  def create
    party = Party.new(
      event_date: Date.parse("#{params["event_date(1i)"]}/#{params["event_date(2i)"]}/#{params["event_date(3i)"]}"),
      duration: params[:duration],
      start_time: Time.parse("#{params["start_time(4i)"]}:#{params["start_time(5i)"]}"),
      user_id: params[:user_id],
      movie_id: params[:movie_id],
      movie_duration: params[:runtime].to_i
    )
    if party.save
      Invitation.create!(user_id: party.user_id, party_id: party.id)
      params[:invited_users].each { |user_id| Invitation.create!(user_id: user_id, party_id: party.id) }
      redirect_to "/dashboard"
    else
      redirect_to "/users/#{party.user_id}/movies/#{params[:movie_id]}/parties/new"
      flash[:invalid_duration] = "Invalid Data: Duration must be greater than or equal to the movie's runtime."
    end
  end
end
