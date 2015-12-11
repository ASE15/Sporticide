class CalendarController < ApplicationController

  before_action :authenticate_user!

  def index
    @sessions = Array.new
    trainings = Training.all
    trainings.each do |t|

      if t.users.include?(current_user)
        @sessions.unshift(*t.training_sessions)
      end

    end
  end
end


