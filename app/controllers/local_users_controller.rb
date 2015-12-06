class LocalUsersController < ApplicationController

  before_action :authenticate_user!

  def index
    if params[:start].nil?
      params[:start] = 0
    end
    if params[:size].nil?
      params[:size] = 20
    end
    @local_users = LocalUser.where(:id => params[:start]..params[:size])
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
