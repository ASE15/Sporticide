class AddRecurrenceToTrainingSession < ActiveRecord::Migration
  def change
    add_column :training_sessions, :recurrence, :string
    add_column :training_sessions, :enddate, :datetime
  end
end
