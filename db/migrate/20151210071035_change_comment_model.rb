class ChangeCommentModel < ActiveRecord::Migration
  def change
    add_reference :comments, :user, references: :local_users, index: true
    add_foreign_key :comments, :local_users, column: :user_id

    remove_column :comments, :datetime
  end
end
