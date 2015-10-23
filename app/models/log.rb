class Log < ActiveRecord::Base
  belongs_to :training_session, :inverse_of => :logs
  belongs_to :cyber_user, :inverse_of => :logs
end
