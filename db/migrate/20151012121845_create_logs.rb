class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :intensity
      t.integer :rating
      t.text :comment

      #t.references :local_user, index: true

      t.references :training_session, index: true

      t.timestamps
    end

    add_reference :logs, :user, references: :local_users, index: true
    add_foreign_key :logs, :local_users, column: :user_id

  end
end
