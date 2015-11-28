class CreateSystemLogs < ActiveRecord::Migration
  def change
    create_table :system_logs do |t|
      t.integer :training_session_id
      t.string :log

      t.timestamps null: false
    end
  end
end
