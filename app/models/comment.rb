class Comment < ActiveRecord::Base
  belongs_to :cyber_user
  belongs_to :training, :inverse_of => :comments
end
