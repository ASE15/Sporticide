class TrainingNotifiersController < ApplicationController

  def index
    @notifications = current_user.training_notifiers
  end
end
