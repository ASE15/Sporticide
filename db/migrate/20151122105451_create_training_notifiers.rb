class CreateTrainingNotifiers < ActiveRecord::Migration
  def change
    create_table :training_notifiers do |t|
      t.isRead :boolean
      t.system_log_id :integer
      t.local_user_id :integer

      t.timestamps null: false
    end
  end
end
