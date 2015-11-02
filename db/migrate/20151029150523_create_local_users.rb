class CreateLocalUsers < ActiveRecord::Migration
  def change
    create_table :local_users do |t|
      t.string :username

      t.timestamps null: false
    end
    # execute "ALTER TABLE LocalUsers ADD PRIMARY KEY (username);"
  end
end
