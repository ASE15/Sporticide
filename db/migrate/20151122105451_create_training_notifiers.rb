class CreateTrainingNotifiers < ActiveRecord::Migration
  def change
    create_table :training_notifiers do |t|
      t.boolean :isRead
      t.integer :system_log_id
      t.integer :local_user_id

      t.timestamps null: false
    end
  end
end
