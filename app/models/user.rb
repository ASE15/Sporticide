require 'active_resource'
class User  < Api::Base
  #has_many :trainings, foreign_key: "owner_id"
  has_and_belongs_to_many :trainings

  has_and_belongs_to_many(:friends,
                          :join_table => "friends",
                          :foreign_key => "user_a_id",
                          :association_foreign_key => "user_b_id")


  has_many :logs


  self.prefix = '/CyberCoachServer/resources/'

  #self.user = "newuser1"
  #self.password = "newuser"

  # To handle the issue with getting the resources by name (e.g. ../resources/sports/Running not ../sports/1)
  # you can set the primary_key to the created api class extending the ActiveResource::Base class.
  self.primary_key = 'username'

  # singular name of the resource. you only need to specify this if this class name is not the resource name
  self.element_name = 'user'

  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['users'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end

  #schema do
  #  string 'uri', 'username', 'password', 'realname', 'email', 'subscriptions', 'partnerships'
  #  integer 'publicvisible'
  #  end

  #validates :lastName,  :presence => true, :length => { :maximum => 50 }
  #validates :firstName, :presence => true, :length => { :minimum => 6 }



 def self.user_signed_in?
   return false
 end


end