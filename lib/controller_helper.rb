module ControllerHelper
  def set_user
    @user = current_user
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
    params['date(2i)'] = '0' + params['date(2i)'] if params['date(2i)'].length == 1
    params['date(3i)'] = '0' + params['date(3i)'] if params['date(3i)'].length == 1
    time_string = params['date(1i)'] + params['date(2i)'] + params['date(3i)'] + params['time(4i)'] + params['time(5i)']
  end

  def set_movie
    @movie = MovieFacade.movie_details(params[:movie_id])
  end

  def friend_ids
    params[:friend_ids].map { |id| id.to_i } if params[:friend_ids]
  end
end
