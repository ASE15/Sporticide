class TrainingNotifier < ActiveRecord::Base
  belongs_to :system_log
  belongs_to :local_user

end
