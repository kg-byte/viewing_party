module ControllerHelper

  def set_user
    @user = User.find(params[:id]) if params[:id]
  end

  def set_user_uid
    @user = User.find(params[:user_id]) if params[:user_id]
  end

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

  def set_movie
    @movie = MovieFacade.movie_details(params[:movie_id])
  end

  def friend_ids
    params[:friend_ids].map { |id| id.to_i } if params[:friend_ids]
  end
end