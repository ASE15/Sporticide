class FriendRequest < ActiveRecord::Base
  belongs_to :user, class_name: 'LocalUser'
  belongs_to :friend, class_name: 'LocalUser'
end
