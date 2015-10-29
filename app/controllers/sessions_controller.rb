require 'rest-client'

class SessionsController < ApplicationController
  def new

  end

  def create
    user = nil
    
    if(env['omniauth.auth']) 
        puts "Hell has frozen over"
        puts(env['omniauth.auth'].info.email)
		puts(env['omniauth.auth'].info.name)
        
		identity = Identity.find_for_oauth(env['omniauth.auth'])
		base64 = Base64.strict_encode64(identity.name).chomp("=")
		
		begin 
		    puts "Try to find user with " + identity.name
		    puts "Base64 : " + base64
		    
			#@user = User.find(identity.name)
			@user = User.find(base64)
		rescue
		    puts "User did not exist. Create new user!"
		    #{"username"=>"Housi", "password"=>"housi", "realname"=>"Housi", "email"=>"housi@test.ch", "publicvisible"=>"2"}
			@user = User.new({"username" => base64, "email" => identity.email, 
				"publicvisible" => 1, "realname" => identity.name, 
				"password" => "blablabla"}, true)
			
			#@user = User.new({"username" => "housi", "email" => "housi@test.ch", 
				#"publicvisible" => 1, "realname" => "housi", 
				#"password" => "blablabla"}, true)
				
			@user.save!
		end
	    
	    puts(identity.name)
		#params[:username] = identity.name
		params[:username] = base64
		params[:passwd] = "blablabla"
    else 
      @user = User.find(params[:username])
    end
    
    puts "Where the hell is my digest?"
    begin
      digest = Base64.encode64(params[:username]+':'+params[:passwd])
      # checks if the user put in the form is a user on cybercoach
      puts "digest " + digest
      RestClient.get 'http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/authenticateduser/', :Authorization => 'Basic '+digest
      status = true
    rescue Exception => e
      status=false
    end

    if @user && status
      if session[:user_id] = @user.username
        session[:passwd] = params[:passwd]
        # begin
         if LocalUser.find_by(username: session[:user_id]).nil?
         # rescue ActiveRecord::RecordNotFound => e
          LocalUser.new(username:  session[:user_id]).save
        end
        redirect_to user_path(@user), :notice => "Logged in! #{LocalUser.find_by(username: session[:user_id])}bla!"
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
