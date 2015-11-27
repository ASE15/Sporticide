class CreateTrainingsUsersJoin < ActiveRecord::Migration
  def self.up
    create_table 'trainings_users', :force => true, :id => false  do |t|
      t.column 'user_id', :integer, :null => false
      t.column 'training_id', :integer, :null => false
    end
  end

  def self.down
    drop_table 'trainings_users'
  end
end