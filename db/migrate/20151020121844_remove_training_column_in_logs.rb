class RemoveTrainingColumnInLogs < ActiveRecord::Migration
  def change
    remove_reference :logs, :training, index: true
  end
end