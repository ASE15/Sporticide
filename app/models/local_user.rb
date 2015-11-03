class LocalUser < ActiveRecord::Base
  validates :plz, length: { in: 4..4 }
  has_many :trainings, foreign_key: "owner_id"
  #has_and_belongs_to_many :trainings
  has_and_belongs_to_many(:trainings,
                          :class_name => "Training",
                          :join_table => "trainings_users",
                          :foreign_key => "user_id",
                          :association_foreign_key => "training_id")

  has_and_belongs_to_many(:friends,
                          :class_name => "LocalUser",
                         :join_table => "friends",
                         :foreign_key => "user_a_id",
                         :association_foreign_key => "user_b_id")


  has_many :logs

end