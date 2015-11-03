class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      #t.references :user, index: true

      t.timestamps
    end

    add_reference :chats, :user, references: :local_users, index: true
    add_foreign_key :chats, :local_users, column: :user_id

    add_reference :chats, :partner, references: :local_users, index: true
    add_foreign_key :chats, :local_users, column: :partner_id

  end
end
