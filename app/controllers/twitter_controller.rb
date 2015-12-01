require 'uri'

class TwitterController < ApplicationController

  before_action :authenticate_user!
  #
  # Problem! The authentification key could be old!
  #
  
  def tweet
  
    identity = Identity.find_by(provider: "twitter", uid: session[:twitter_uid])
    
    tweet = params.require(:message)
    redirect = params.require(:redirect_uri)
    
    # If we couldn't find an identity then we login again
    if(identity.nil?) 
	    session[:session_back] = "/twitter/tweet?message=" + URI.encode(tweet)
      redirect_to "/auth/twitter"
      return
    end
      
    begin
	  client = Twitter::REST::Client.new do |config|
	    config.consumer_key        = ENV["TWITTER_KEY"]
	    config.consumer_secret     = ENV["TWITTER_SECRET"]
	    config.access_token        = identity.accesstoken
	    config.access_token_secret = identity.secret
	  end

	  client.update(tweet)
    rescue Twitter::Error::Forbidden => e
	   error = "You already tweeted about this training!"
    end

	  if(error)
      redirect_to redirect, alert: error
	  else
      redirect_to redirect, notice: "You successfully tweeted about this auction!"
	  end
  end
end
