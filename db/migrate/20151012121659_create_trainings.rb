class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.boolean :isPublic
      t.string :title
      t.text :description
      t.string :sport


      t.timestamps
    end

    add_reference :trainings, :owner, references: :local_users, index: true
    add_foreign_key :trainings, :local_users, column: :owner_id

  end
end
