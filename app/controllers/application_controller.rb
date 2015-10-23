class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def owns_training!
    unless is_own_training?
      flash[:error] = 'You are not the owner of this training!'
      redirect_to trainings_path
    end
  end

  def is_own_training?
    @training = Training.find(params[:training_id].nil? ? params[:id] : params[:training_id])
    @training.owner == current_user
  end

  def owns_log!
    @log = Log.find(params[:id])
    if not @log.cyber_user == current_user
      flash[:error] = 'You are not the owner of this log!'
      redirect_to @log.training_session.training
    end
  end

  def is_member_of_training!
    @training = Training.find(params[:training_id].nil? ? params[:id] : params[:training_id])
    if not @training.cyber_users.exists?(current_user)
      flash[:error] = 'You are not a member of this training!'
      redirect_to @training
    end
  end

  def current_user
    @current_user ||= CyberUser.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def user_signed_in?
    if current_user.nil?
      return false
    end
    return true
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless user_signed_in?
      params[:errors] = "Not logged in!"
      redirect_to root
    end
  end
  helper_method :authenticate_user!

end
