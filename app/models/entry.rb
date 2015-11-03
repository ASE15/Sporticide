require 'active_resource'
class Entry < Api::Base

  self.prefix = '/CyberCoachServer/resources/users/:user/:sport/'

  #self.user = "newuser1"
  #self.password = "newuser"

  headers['Authorization'] = 'Basic '+ Base64.encode64(self.user+':'+self.password)

  # To handle the issue with getting the resources by name (e.g. ../resources/sports/Running not ../sports/1)
  # you can set the primary_key to the created api class extending the ActiveResource::Base class.
  #self.primary_key = 'entry'

  # singular name of the resource. you only need to specify this if this class name is not the resource name
  self.element_name = 'entry'

  class << self
    def instantiate_collection(collection, prefix_options = {}, b = nil)
      collection = collection['entries'] if collection.instance_of?(Hash)
      collection.collect! { |record| instantiate_record(record, prefix_options) }
    end
  end


  schema do
    string 'entrylocation','entryduration','entrydate','comment','coursetype','bicycletype'
    integer 'publicvisible','courselength','roundduration','numberofrounds'
    end
end