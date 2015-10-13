class CreateSportColumnInTraining < ActiveRecord::Migration
  def self.up
    add_column :trainings, :sport, :string
  end
  def self.down
    remove_column :trainings, :sport, :string
  end
end
