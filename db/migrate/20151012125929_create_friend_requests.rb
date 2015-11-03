class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      #t.references :user, index: true

      t.timestamps
    end

    add_reference :friend_requests, :user, references: :local_users, index: true
    add_foreign_key :friend_requests, :local_users, column: :user_id

    add_reference :friend_requests, :friend, references: :users, index: true
    add_foreign_key :friend_requests, :users, column: :friend_id
  end
end
