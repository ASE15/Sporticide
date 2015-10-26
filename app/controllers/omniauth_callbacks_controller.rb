class OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  def facebook
    generic_callback('facebook')
  end
  
  def generic_callback( provider )   
   #
   # If there is a session set for the facebook data then
   # we use this to create or find our identity. This
   # session is set if facebook does not provide an
   # email adress. See below!
   #
    if(session["devise.facebook_data"])
      @identity = Identity.find_for_facebook session["devise.facebook_data"]
      session["devise.facebook_data"] = nil
    else 
	  @identity = Identity.find_for_oauth env["omniauth.auth"]
    end

    @user = @identity.user || current_user
    if @user.nil?
      @user = User.create( email: @identity.email || "" )
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    #
    # Only allow sign in if there is an email existing
    #
    if not @user.email.blank? && @user.persisted?
      # This is because we've created the user manually, and Device expects a
	  # FormUser class (with the validations)
	  @user = FormUser.find @user.id
      @identity.update_attribute( :user_id, @user.id )
      sign_in_and_redirect @user, event: :authentication
      
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      #
      # If there is no email provided (this might happen with facebook)
      # we prompt the user to add an email address manually.
      #
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      flash[:notice] = "Facebook does not return an email for your account. Please provide one and click \"Sign up\". You don't have to add a password. You have to do this only once. Next time you can normally sign in with Facebook."
      redirect_to new_user_registration_url
    end
  end
end
