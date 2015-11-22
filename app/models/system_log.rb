class SystemLog < ActiveRecord::Base
  belongs_to :training_session
  has_many :training_notifiers, :inverse_of => :system_log, :dependent => :destroy
end
