class FriendsController < ApplicationController

  before_action :authenticate_user!

  def index
    @myfriends = current_user.friends
  end

  def create
      mynewfriend = LocalUser.find(params[:mynewfriend])
      mynewfriend.friends << current_user
      @currentuser = LocalUser.find(current_user)
      @currentuser.friends << mynewfriend
      redirect_to friends_path
  end
end
