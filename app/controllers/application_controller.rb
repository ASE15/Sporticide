class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def owns_training!
    unless is_own_training?
      flash[:error] = 'You are not the owner of this bike!'
      redirect_to mybikes_path
    end
  end

  def is_own_training?
    @training = Training.find(params[:training_id].nil? ? params[:id] : params[:training_id])
    @training.owner == current_user
  end
end
