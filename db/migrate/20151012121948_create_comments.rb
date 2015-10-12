class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.datetime :datetime

      t.timestamps
    end
  end
end
