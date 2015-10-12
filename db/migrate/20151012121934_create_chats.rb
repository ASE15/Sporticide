class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.references :user, index: true

      t.timestamps
    end

    add_reference :chats, :partner, references: :users, index: true
    add_foreign_key :chats, :users, column: :partner_id

  end
end