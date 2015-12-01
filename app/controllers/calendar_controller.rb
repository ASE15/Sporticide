class CalendarController < ApplicationController

  def index
    @trainings = current_user.trainings
  end
end


