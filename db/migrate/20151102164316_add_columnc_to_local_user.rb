class AddColumncToLocalUser < ActiveRecord::Migration
  def change
    add_column :local_users, :password, :string
  end
end
