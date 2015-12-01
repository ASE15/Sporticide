class TrainingNotifiersController < ApplicationController

  before_action :authenticate_user!

  def index
    @notifications = current_user.training_notifiers
  end
end
