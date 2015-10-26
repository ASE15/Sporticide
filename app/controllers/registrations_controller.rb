class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    # 
    # If the registration was rerouted because facebook didn't set
    # return an email address then a soon as the user has set an
    # email address we set add the supplied email address to 
    # the facebook data and redirect to the facebook
    # authorization provided through omniauth
    #
    if(session["devise.facebook_data"])	
      session["devise.facebook_data"]["info"]["email"] = resource.email
      session["devise.facebook_data"]["extra"]["raw_info"]["email"] = resource.email
      redirect_to "/users/auth/facebook/callback"
    else
		resource.save
		yield resource if block_given?
		if resource.persisted?
		  if resource.active_for_authentication?
			set_flash_message :notice, :signed_up if is_flashing_format?
			sign_up(resource_name, resource)
			respond_with resource, location: after_sign_up_path_for(resource)
		  else
			set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
			expire_data_after_sign_in!
			respond_with resource, location: after_inactive_sign_up_path_for(resource)
		  end
		else
		  clean_up_passwords resource
		  respond_with resource
		end
	end
  end
end
