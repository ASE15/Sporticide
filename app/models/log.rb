class Log < ActiveRecord::Base
  belongs_to :training_session, :inverse_of => :logs
  belongs_to :user, class_name: 'LocalUser', :inverse_of => :logs

  validates :comment, :length => { :minimum => 1 }, allow_nil: false, allow_blank: false
end
