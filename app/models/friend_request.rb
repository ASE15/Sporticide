class FriendRequest < ActiveRecord::Base
  belongs_to :cyber_user
  belongs_to :friend, class_name: 'CyberUser'
end
