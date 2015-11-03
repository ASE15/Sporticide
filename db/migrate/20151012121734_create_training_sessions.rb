class CreateTrainingSessions < ActiveRecord::Migration
  def change
    create_table :training_sessions do |t|
      t.datetime :datetime
      t.integer :duration
      t.integer :level
      t.integer :length
      t.string :location

      t.references :training, index:true

      t.timestamps
    end
  end
end
