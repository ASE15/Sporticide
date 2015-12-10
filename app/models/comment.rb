class Comment < ActiveRecord::Base
  belongs_to :user, class_name: 'LocalUser'
  belongs_to :training, :inverse_of => :comments

  validates :text, :length => { :minimum => 1 }, allow_nil: false, allow_blank: false
end
