class Training < ActiveRecord::Base
  belongs_to :owner, class_name: 'LocalUser'
  has_many :training_sessions, :inverse_of => :training, :dependent => :destroy
  has_many :comments, :inverse_of => :training, :dependent => :destroy

  #has_and_belongs_to_many :users

  has_and_belongs_to_many(:users,
                          :class_name => "LocalUser",
                          :join_table => "trainings_users",
                          :foreign_key => "training_id",
                          :association_foreign_key => "user_id")

  # has_and_belongs_to_many(:members,
  #                        :join_table => "members_trainings",
  #                        :foreign_key => "training_id",
  #                        :association_foreign_key => "user_id")
  
  def self.get_all_locations()
    locations = []
    
    @relation.each do |training| 
      training.training_sessions.each do |session|
        if not session.location.nil? and not session.location.empty? and not locations.include?(session.location)
          locations.push(session.location)
        end
      end
    end
    
    return locations
  end
  
  def get_locations()
    locations = []
    training_sessions.each do |session|
        if not session.location.nil? and not session.location.empty? and not locations.include?(session.location)
          locations.push(session.location)
        end
    end
    
    return locations
  end
  
  def get_recurrences()
    repetitions = []
    training_sessions.each do |session|
      if not session.recurrence.nil? and not session.recurrence.empty? and not repetitions.include?(session.recurrence)
        repetitions.push(session.recurrence)
      end
    end
    return repetitions
  end
  
  def get_first_time()
    first_time = nil
    training_sessions.each do |session|
      if not session.datetime.nil? and (first_time.nil? or session.datetime < first_time)
        first_time = session.datetime
      end
    end
    
    
    return first_time
  end
  
  def get_last_time()
    last_time = nil
    training_sessions.each do |session|
      if not session.enddate.nil? and (last_time.nil? or session.enddate < last_time)
        last_time = session.enddate
      end
    end
    return last_time
  end
end
