class Comment < ActiveRecord::Base
  belongs_to :user, class_name: 'LocalUser'
  belongs_to :training, :inverse_of => :comments
end
