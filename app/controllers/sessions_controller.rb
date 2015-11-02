require 'rest-client'

class SessionsController < ApplicationController
  def new

  end
  
  def facebook
    if(env['omniauth.auth'])         
		identity = Identity.find_for_oauth(env['omniauth.auth'])
		
		if(params[:username])
			identity.nickname = params[:username]
			identity.save!
        end
		
		begin 
			@user = User.find(identity.nickname)
			local_user = LocalUser.find_by(username: identity.nickname)
			params[:username]=identity.nickname
			params[:passwd] = local_user.password
		rescue
			session[:facebook_auth] = true
			session[:facebook_uid] = identity.uid
			session[:facebook_provider] = identity.provider
			redirect_to('/users/new', :notice => "The first time you login with facebook, we need"\
			 "some additional information of you. Please fill in the form and click on "\
			 "\'Sign in\'. You only have to do this once and then you can "\
			 "use the \"Sign in with facebook\" button as usual.") and return
		end
    end
 
    create  
  end

  def create     
    @user = User.find(params[:username])   

    begin
      digest = Base64.encode64(params[:username]+':'+params[:passwd])
      # checks if the user put in the form is a user on cybercoach
      RestClient.get 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/authenticateduser/', :Authorization => 'Basic '+digest
      status = true
    rescue Exception => e
      status=false
    end

    if @user && status
      if session[:user_id] = @user.username
        session[:passwd] = params[:passwd]
        
        if LocalUser.find_by(username: session[:user_id]).nil?
          LocalUser.new(username:  session[:user_id]).save!
        end
        
        redirect_to user_path(@user), :notice => "Logged in!"
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
