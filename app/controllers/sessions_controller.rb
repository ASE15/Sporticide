require 'rest-client'
class SessionsController < ApplicationController
  def new

  end

  def create
    user = CyberUser.find(params[:username])
    begin
      digest = Base64.encode64(params[:username]+':'+params[:passwd])
      # checks if the cyber_user put in the form is a cyber_user on cybercoach
      RestClient.get 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/authenticateduser/', :Authorization => 'Basic '+digest
      status = true
    rescue Exception => e
      status=false
    end

    if user && status
      if session[:user_id] = user.username
        session[:passwd] = params[:passwd]
        redirect_to user_path(user), :notice => "Logged in!"
      end
    else
      flash.now.alert = "Wrong login!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:passwd] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
