class Log < ActiveRecord::Base
  belongs_to :training_session, :inverse_of => :logs
  belongs_to :user, class_name: 'LocalUser', :inverse_of => :logs
end
