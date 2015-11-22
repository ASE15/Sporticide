class CreateTrainingNotifiers < ActiveRecord::Migration
  def change
    create_table :training_notifiers do |t|
      t.system_log_id :integer
      t.local_user_id :integer
      t.isRead :boolean

      t.timestamps null: false
    end
  end
end
