class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.boolean :isPublic
      t.string :title
      t.text :description
      t.references :session, index: true
      t.references :comment, index: true

      t.timestamps
    end

    add_reference :trainings, :owner, references: :users, index: true
    add_foreign_key :trainings, :CyberUsers, column: :owner_id

  end
end
