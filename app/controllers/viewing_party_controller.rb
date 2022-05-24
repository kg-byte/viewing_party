class ViewingPartyController < ApplicationController
  include ControllerHelper

  before_action :set_user, :set_movie, :require_user
  def new
    @party = Party.new(party_params)
  end

  def create
      @party = Party.create(party_proper_params)
    if @party.save
      PartyUser.create(user_id: params[:user_id], party_id: @party.id, is_host: true)
      friend_ids.each { |id| PartyUser.create(user_id: id, party_id: @party.id, is_host: false) } if friend_ids
      redirect_to dashboard_path
    else
      redirect_to new_dashboard_movie_viewing_party_path(@movie.id)
      flash[:alert] = "#{@party.errors.full_messages.to_sentence}"
    end
  end

  def destroy
      Party.destroy(params[:id])
      flash[:notice] = 'You have successfully deleted the viewing party'
    if params[:user_id]
      redirect_to user_path(params[:user_id])
    else
      redirect_to '/admin/dashboard'
    end
  end

end
