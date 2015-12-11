require 'transprt'

class TrainingSessionValidator < ActiveModel::Validator
  def validate(record)


    #unless record.name.starts_with? 'X'
    #  record.errors[:name] << 'Need a name starting with X please!'
    #end
    check_enddate(record)
    is_valid_enddate?(record)
    check_distance(record)
    check_duration(record)
    check_location(record)
  end

  def check_distance(record)
    if record.length.nil? or not record.length or record.length == 0
      record.errors[:length] << "Distance must not be empty or 0"
    end
  end

  def check_location(record)
    if record.location.nil? or record.location.empty?
      record.errors[:location] << "Location must not be empty"
    end
  end

  def check_duration(record)
    if record.duration.nil? or not record.duration or record.duration == 0
      record.errors[:duration] << "Duration must not be empty or 0"
    end
  end

  def check_enddate(record)
    if record.recurrence == "never"
      record.enddate = nil
    end
  end

  def is_valid_enddate?(record)
    if record.recurrence == "never" or record.enddate.nil?
      return
    end

    now = DateTime.now
    if record.enddate <= record.datetime
      record.errors[:enddate] << "End date is behind start date"
    end

    checkdate = record.datetime

    case record.recurrence
      when "daily"
        checkdate = DateTime.now + 1.days
      when "weekly"
        checkdate = DateTime.now + 1.weeks
      when "monthly"
        checkdate = DateTime.now + 1.months
    end

    if record.enddate < checkdate
      record.errors[:enddate] << "The first next date is after the end date."
    end
  end
end


class TrainingSession < ActiveRecord::Base

  include ActiveModel::Validations

  #before_save :check_enddate, :is_valid_enddate?

  belongs_to :training
  has_many :logs, :inverse_of => :training_session, :dependent => :destroy
  has_many :system_logs, :inverse_of => :training_session

  #validates :enddate, :if => :is_valid_enddate?
  validates_with TrainingSessionValidator, :on => :update

  validates_with TrainingSessionValidator, :on => :create

  def get_connection_to(from)
    begin
      connection = Transprt.connections :from => from, :to => location, :isArrivalTime => 1, :date => datetime.strftime("%Y-%m-%d"), :time => datetime.strftime("%H-%M")
    rescue Exception => e
      puts e
    end

    return connection.nil? ? nil : connection[0]
  end

  def user_already_logged?(user)
    count = 0
    self.logs.each do |l|
      if l.user == user
        count += 1
      end
    end
    if count > get_recurrence_steps
      return true
    end
    return false
  end

  def get_recurrence_steps
    if self.enddate.nil?
      return 1
    end
    timespan = self.enddate - self.datetime
    case self.recurrence
      when "daily"
        steps = timespan / 1.days
      when "weekly"
        steps = timespan / 1.weeks
      when "monthly"
        steps = timespan / 1.months
      else
        steps = 1
    end
    return steps.floor
  end

  def get_recurrence_dates
    if self.enddate.nil?
      return Array.new
    end

    results = Array.new
    results.push(self.datetime)
    steps = get_recurrence_steps
    for i in 1..steps
      case self.recurrence
        when "daily"
          d = self.datetime + i.days
        when "weekly"
          d = self.datetime + i.weeks
        when "monthly"
          d = self.dateimte + i.months
      end
      results.push(d)
    end
    return results
  end
end
