class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :training, :inverse_of => :comments
end
