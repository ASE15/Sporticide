class CalendarController < ApplicationController

  before_action :authenticate_user!

  def index
    @trainings = current_user.trainings
  end
end


