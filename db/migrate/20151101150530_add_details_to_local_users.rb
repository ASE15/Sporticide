class AddDetailsToLocalUsers < ActiveRecord::Migration
  def change
    add_column :local_users, :firstname, :string
    add_column :local_users, :lastname, :string
    add_column :local_users, :height, :integer
    add_column :local_users, :weight, :integer
    add_column :local_users, :address, :string
    add_column :local_users, :address_nr, :string
    add_column :local_users, :plz, :integer
    add_column :local_users, :place, :string
  end
end
