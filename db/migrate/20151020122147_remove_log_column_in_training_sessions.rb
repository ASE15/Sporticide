class RemoveLogColumnInTrainingSessions < ActiveRecord::Migration
  def change
    remove_reference :training_sessions, :log, index: true
  end
end
