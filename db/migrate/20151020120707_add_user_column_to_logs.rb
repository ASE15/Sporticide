class AddUserColumnToLogs < ActiveRecord::Migration
  def change
    add_reference :logs, :user, index: true
  end
end
