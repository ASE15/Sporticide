class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.references :cyber_user, index: true

      t.timestamps
    end

    add_reference :friend_requests, :friend, references: :users, index: true
    add_foreign_key :friend_requests, :CyberUsers, column: :friend_id
  end
end
