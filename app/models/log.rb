class Log < ActiveRecord::Base
  belongs_to :training_session, :inverse_of => :logs
end
