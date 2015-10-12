class Log < ActiveRecord::Base
  belongs_to :trainingsession, :inverse_of => :logs
end
