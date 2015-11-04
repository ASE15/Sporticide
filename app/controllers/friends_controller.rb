class FriendsController < ApplicationController

  before_action :authenticate_user!

  def index
    if params[:start].nil?
      params[:start] = 0
    end
    if params[:size].nil?
      params[:size] = 20
    end
    @myfriends = current_user.friends.where(:id => params[:start]..params[:size])
  end

  def create
      mynewfriend = LocalUser.find(params[:mynewfriend])
      currentuser = LocalUser.find(current_user)
      mynewfriend.friends.detect{|f| f.id == currentuser.id}
      if mynewfriend != currentuser && !(mynewfriend.friends.detect { |f| f.id == currentuser.id })
        mynewfriend.friends << currentuser
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
    myoldfriend = LocalUser.find(params[:id])
    myoldfriend.friends.delete(current_user)
    current_user.friends.delete(myoldfriend)
    redirect_to friends_path, :notice => 'Friend removed.'
  end
end
