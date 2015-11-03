class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.datetime :datetime
      t.boolean :isRead
      t.text :text
      #t.references :user

      t.references :chat, index:true

      t.timestamps
    end
    add_reference :messages, :sender, references: :local_user, index: true
    add_foreign_key :messages, :local_users, column: :sender_id
    add_reference :messages, :receiver, references: :local_user, index: true
    add_foreign_key :messages, :local_users, column: :receiver_id

  end
end
