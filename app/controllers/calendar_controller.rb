class CalendarController < ApplicationController

  def index
    trainings = current_user.trainings
    trainings.each do |t|
      t.training_sessions.each do |s|
        if s.recurrence == 'never'
          FullcalendarEngine::Event.create({
              :title => t.title,
              :description => t.description,
              :starttime => s.datetime.to_time(),
              :endtime => s.datetime.to_time() + 60.minute
              })
        else
          FullcalendarEngine::EventSeries.create({
             :title => t.title,
              :description => t.description,
              :starttime => s.datetime.to_time(),
              :endtime => s.datetime.to_time() + 60.minute,
              :period => s.recurrence,
               :frequency => s.get_recurrence_steps
                                                 })
        end
      end

    end
  end

  def create

  end
end
