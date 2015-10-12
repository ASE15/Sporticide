class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :intensity
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
