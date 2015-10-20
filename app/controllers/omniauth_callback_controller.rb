class OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  def facebook
    generic_callback('facebook')
  end
  
  def generic_callback( provider )
    puts(session)
    puts(env["omniauth.auth"])
  end
end
