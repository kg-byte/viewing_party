module ControllerHelper

  def remember_me
    if !cookies[:remember_me]
      redirect_to '/login'
      flash[:notice] = 'Your session has expired, please log in again!'
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_uid
    @user = User.find(params[:user_id])
  end


end