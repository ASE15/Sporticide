class AddSessionColumnToLogs < ActiveRecord::Migration
  def change
    add_reference :logs, :training_session, index: true
  end
end
