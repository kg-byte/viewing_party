module ControllerHelper

  def set_user
    @user = User.find(params[:id]) if params[:id]
  end

  def set_user_uid
    @user = User.find(params[:user_id]) if params[:user_id]
  end


end