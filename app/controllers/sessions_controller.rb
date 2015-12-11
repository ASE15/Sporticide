require 'rest-client'

class SessionsController < ApplicationController

	skip_before_filter :redirect_if_not_authenticated

  def new
		render 'new', layout: 'login'
  end
  
  #
  # Twitter sessions do only exist for very short
  # time. As soon as the message was send the
  # session is immediately destroyed
  #
  # Requires
  #  session[:session_back] : the path to redirect after auth
  #
  # Sets
  #  session[:twitter_uid] : uid of twitter user
  #
  def twitter
	identity = Identity.find_for_oauth(env['omniauth.auth'])
	identity.save!

	session[:twitter_uid] = identity.uid
	
	back = session[:session_back]
	session[:session_back] = nil
	
	redirect_to back
  end
  
  def facebook
    # Create or get an identity for oauth     
	identity = Identity.find_for_oauth(env['omniauth.auth'])
	identity.save!
	session[:provider] = identity.provider
	session[:uid] = identity.uid
	
	# Find user with identity nickname. If the
	# identity.nickname does not exist or the
	# user does not exist then we assume that
	# we are in the first round of facebook
	# login.
	#
	# If the user with the identity.nickname does exist
	# then we assume that a LocalUser exists with
	# this user name.
	begin
		@user = User.find(identity.nickname)
		local_user = LocalUser.find(username: identity.nickname)

		if !@user || !local_user	
			redirect_to new_session_path, :alert => "Could not find " + identity.nickname
			return
		end
		
		unless authenticated_user?(local_user.password)
			redirect_to new_session_path, :alert => "Could not autheticate " + identity.nickname
			return
		end
		
		sign_in local_user.password
	rescue
		session[:user] = {}
	    session[:user]["email"] = identity.email
	    session[:user]["realname"] = identity.name
		redirect_to new_user_path, :notice => "The first time you login with facebook, we need "\
		 "some additional information of you. Please fill in the form and click on "\
		 "\'Sign in\'. You only have to do this once and then you can "\
		 "use the \"Sign in with facebook\" button as usual."
		return
	end
  end

  def create   
    begin 
		@user = User.find(params[:username])
	rescue
		redirect_to :back, :alert => "Please provide correct user name"
		return
	end   

    if @user && authenticated_user?(params[:passwd])
    
		# Create a new local user if it does not already exist
		# This is because the user can login with the user
		# account of CyberCoach even if she never filled
		# in the registration form
		
        if LocalUser.find_by(username: @user.username).nil?
          LocalUser.new(username: @user.username).save!
        end
        
        sign_in params[:passwd]
    else
      redirect_to new_session_path, :alert => "Please provide correct password!"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:passwd] = nil
    session[:provider] = nil
	session[:uid] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
  def sign_in(password)
	session[:user_id] = @user.username
	session[:passwd] = password
	redirect_to root_path, :notice => "Logged in!"
  end
  
  def authenticated_user?(password)
    begin
      digest = Base64.encode64(@user.username+':'+password)
      # checks if the user put in the form is a user on cybercoach
      RestClient.get 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/authenticateduser/', :Authorization => 'Basic '+digest
      return true
    rescue Exception => e
      return false
    end
  end
end
