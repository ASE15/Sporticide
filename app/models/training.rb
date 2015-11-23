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
end
