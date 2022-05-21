class ViewingPartyController < ApplicationController
  before_action :set_user, :set_movie
  def new
    @party = Party.new(party_params)
  end

  def create
      @party = Party.create(party_proper_params)
    if @party.save
      PartyUser.create(user_id: params[:user_id], party_id: @party.id, is_host: true)
      friend_ids.each { |id| PartyUser.create(user_id: id, party_id: @party.id, is_host: false) } if friend_ids
      redirect_to user_path(@user)
    else
      redirect_to new_user_movie_viewing_party_path(@user.id, @movie.id)
      flash[:alert] = "#{@party.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    Party.destroy(params[:id])
    redirect_to user_path(params[:user_id])
  end

  private

  def party_params
    params.permit(:movie_id, :duration, :data, :time)
  end

  def party_proper_params
    party_params = {}
    party_params[:time] = time_format
    party_params[:movie_id] = params[:movie_id]
    party_params[:duration] = params[:duration_user]
    party_params
  end

  def time_format
    params['time(2i)'] = '0' + params['time(2i)'] if params['time(2i)'].length == 1
    time_string = params['time(1i)'] + params['time(2i)'] + params['time(3i)'] + params['time(4i)'] + params['time(3i)']
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_movie
    @movie = MovieFacade.movie_details(params[:movie_id])
  end

  def friend_ids
    params[:friend_ids].map { |id| id.to_i } if params[:friend_ids]
  end
end
