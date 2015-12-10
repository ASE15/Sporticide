class ProfileController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update]

  # def index
  #   @profile = current_user
  # end

  def show
    @profile = current_user
  end

  def profile
    @profile = LocalUser.find_by(username: params[:username])
    render 'show'
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user

    if @profile.update(profile_params)
      redirect_to profile_path, :notice => "Profile successfully edited."
    else
      render 'edit'
    end
  end

  private
  def profile_params
    params.require(:local_user).permit(:firstname, :lastname, :height, :weight, :address, :address_nr, :plz, :place, :date)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    #User.user = session[:user_id]
    #User.password = session[:passwd]
    Api::Base.user = session[:user_id]
    Api::Base.password = session[:passwd]

    begin
      @user = User.find(current_user.username)
    rescue ActiveResource::ResourceNotFound
      flash[:error] = 'No user found'
      redirect_to users_path
    rescue ActiveResource::ResourceConflict, ActiveResource::ResourceInvalid
      redirect_to new_user_path
    end
  end
end
