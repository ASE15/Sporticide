class AddDateOfBirthToLocalUser < ActiveRecord::Migration
  def change
    add_column :local_users, :date, :date_of_birth
  end
end
