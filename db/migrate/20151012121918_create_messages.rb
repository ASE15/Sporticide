class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.datetime :datetime
      t.boolean :isRead
      t.text :text
      t.references :cyber_user

      t.timestamps
    end
    add_reference :messages, :sender, references: :user, index: true
    add_foreign_key :messages, :CyberUsers, column: :sender_id
    add_reference :messages, :receiver, references: :user, index: true
    add_foreign_key :messages, :CyberUsers, column: :receiver_id

  end
end
