class LocalUsersController < ApplicationController
  def index
     @local_users = LocalUser.all
  end
  # def addUser
  #   user = LocalUser.new()
  #   user.username = "test"
  # end
  
  def show
     user = User.find(current_user.username)
     redirect_to user_path(user) 
  end
end
