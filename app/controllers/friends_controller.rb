class FriendsController < ApplicationController

  before_action :authenticate_user!

  def index
    @myfriends = current_user.friends
  end

  def create
      mynewfriend = LocalUser.find(params[:mynewfriend])
      currentuser = LocalUser.find(current_user)
      mynewfriend.friends.detect{|f| f.id == currentuser.id}
      if mynewfriend != currentuser && !(mynewfriend.friends.detect { |f| f.id == currentuser.id })
        mynewfriend.friends << current_user
        currentuser.friends << mynewfriend
        redirect_to friends_path, :notice => 'Friend added.'
      else
        if (mynewfriend == currentuser)
          redirect_to local_users_path, :alert => 'You cant add yourself as a friend.'
        else
          redirect_to local_users_path, :alert => 'This user is already your friend.'
        end
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
