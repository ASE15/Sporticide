class ChangeMessageModel < ActiveRecord::Migration
  def change
    #remove_reference :messages, :user
    #rename_column :chats, :user, :sender
    #rename_column :chats, :partner, :receiver

    remove_foreign_key :messages, column: :sender_id
    remove_reference :messages, :sender
    remove_foreign_key :messages, column: :receiver_id
    remove_reference :messages, :receiver

    remove_column :messages, :isRead

    add_column :chats, :userRead, :boolean
    add_column :chats, :partnerRead, :boolean
  end
end
