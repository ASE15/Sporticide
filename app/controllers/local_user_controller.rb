class LocalUserController < ApplicationController
  def index
     @local_users = LocalUser.all
  end
  # def addUser
  #   user = LocalUser.new()
  #   user.username = "test"
  # end




end
