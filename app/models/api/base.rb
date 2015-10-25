class Api::Base < ActiveResource::Base

  #### More information about how to work with ActiveResource::Base can be found on GitHub
  #### https://github.com/rails/activeresource/blob/master/lib/active_resource/base.rb

  self.site='http://diufvm31.unifr.ch:8090'
  self.prefix = '/CyberCoachServer/resources/'

  #### Either this
  #self.user = "newuser1"
  #sself.password = "newuser"

  #### Or this
  #headers['Authorization'] = 'Basic YWRtaW46NGRtMW4xZA=='



  headers['Accept'] = 'application/json'
  self.format = :json


  # that activeresource doesnt send https://api.example.com/contracts.xml or .json, but https://api.example.com/contracts
  class << self
    def element_path(id, prefix_options = {}, query_options = nil)
      super.gsub(/.json|.xml/,'')
    end

    def collection_path(prefix_options = {}, query_options = nil)
      super.gsub(/.json|.xml/,'')
    end

    def new_element_path
      super.gsub(/.json|.xml/,'')
    end
  end
end
