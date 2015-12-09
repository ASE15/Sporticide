class FriendsController < ApplicationController

  before_action :authenticate_user!

  def index
    @myfriends = current_user.friends
  end

  def create
      mynewfriend = LocalUser.find(params[:mynewfriend])
      mynewfriend.friends.detect{|f| f.id == current_user.id}
      if mynewfriend != current_user && !(mynewfriend.friends.detect { |f| f.id == current_user.id })
        mynewfriend.friends << current_user
        current_user.friends << mynewfriend
        redirect_to friends_path, :notice => 'Friend added.'
      else
        if (mynewfriend == current_user)
          redirect_to local_users_path, :alert => 'You cant add yourself as a friend.'
        else
          redirect_to local_users_path, :alert => 'This user is already your friend.'
        end
      end
  end

  def destroy
    myoldfriend = LocalUser.find(params[:id])
    myoldfriend.friends.delete(current_user)
    current_user.friends.delete(myoldfriend)
    redirect_to friends_path, :notice => 'Friend removed.'
  end
end
