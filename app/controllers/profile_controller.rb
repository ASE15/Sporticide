class ProfileController < ApplicationController

  # def index
  #   @profile = current_user
  # end

  def show
    @profile = current_user
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user

    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private
  def profile_params
    params.require(:local_user).permit(:firstname, :lastname, :height, :weight, :address, :address_nr, :plz, :place)
  end
end
