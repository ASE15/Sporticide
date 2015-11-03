class FriendsController < ApplicationController

  before_action :authenticate_user!

  def index
    @myfriends = current_user.friends
  end

  def create
      mynewfriend = LocalUser.find(params[:mynewfriend])
      currentuser = LocalUser.find(current_user)
      if (mynewfriend != currentuser)
        mynewfriend.friends << current_user
        currentuser.friends << mynewfriend
        redirect_to friends_path, :notice => 'Friend added.'
      else
        redirect_to friends_path, :alert => 'You cant add yourself as a friend'
      end
  end

  def destroy
    myoldfriend = LocalUser.find(params[:myoldfriend])
    myoldfriend.friends >> current_user
    currentuser = LocalUser.find(current_user)
    currentuser.friends >> current_user
    redirect_to friends_path
  end
end
