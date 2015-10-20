class RenameUserTrainingJoinTable < ActiveRecord::Migration
  def change
    rename_table :members_trainings, :trainings_users
  end
end
