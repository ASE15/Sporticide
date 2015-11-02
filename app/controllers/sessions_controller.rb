require 'rest-client'

class SessionsController < ApplicationController
  def new

  end
  
  def facebook
    if(env['omniauth.auth']) 
        puts "Hell has frozen over"
        if(session[:facebook_auth])
          puts params
          puts "I'm currently in facebook authorization mode"
        end
        
        puts(params[:passwd])
        puts(params[:username])
        puts(env['omniauth.auth'].info.email)
		puts(env['omniauth.auth'].info.name)
        
		identity = Identity.find_for_oauth(env['omniauth.auth'])
		env['omniauth.auth'] = nil
		
		if(params[:username])
			identity.nickname = params[:username]
			identity.save!
        end
		
		#base64 = Base64.strict_encode64(identity.name).chomp("=")
		
		begin 
		    puts "Try to find user with " + identity.nickname
			@user = User.find(identity.nickname)
			params[:username]=identity.nickname
			params[:passwd] = @user.password
			puts(@user.password)
		rescue
			session[:facebook_auth] = true
			session[:facebook_uid] = identity.uid
			session[:facebook_provider] = identity.provider
			redirect_to('/users/new', :notice => "The first time you login with facebook, we need"\
			 "some additional information of you. Please fill in the form and click on "\
			 "\'Login with facebok\' again. You only have to do this once and then you can "\
			 "use the \"Sign in with facebook\" button as usual.") and return
			
		    #puts "User did not exist. Create new user!"
		    #{"username"=>"Housi", "password"=>"housi", "realname"=>"Housi", "email"=>"housi@test.ch", "publicvisible"=>"2"}
			#@user = User.new({"username" => base64, "email" => identity.email, 
			#	"publicvisible" => 1, "realname" => identity.name, 
			#	"password" => "blablabla"}, true)
			
			#@user = User.new({"username" => "housi", "email" => "housi@test.ch", 
				#"publicvisible" => 1, "realname" => "housi", 
				#"password" => "blablabla"}, true)
				
			#@user.save!
		end
	    
	    #puts(identity.name)
		#params[:username] = base64
		#params[:passwd] = "blablabla"
    end
 
    create  
  end

  def create     
    @user = User.find(params[:username])   

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
