class CreateLocalUsers < ActiveRecord::Migration
  def change
    create_table :local_users, {:id => false} do |t|
      t.string :local_user_id, index: true
      t.timestamps null: false
    end
  end
  execute "ALTER TABLE local_user ADD PRIMARY KEY (local_user_id);"
end
