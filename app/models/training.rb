class Training < ActiveRecord::Base
  belongs_to :owner, class_name: 'LocalUser', :dependent => :destroy
  has_many :training_sessions, :inverse_of => :training, :dependent => :destroy
  has_many :comments, :inverse_of => :training, :dependent => :destroy


  #has_and_belongs_to_many :users

  has_and_belongs_to_many(:users,
                          :class_name => "LocalUser",
                          :join_table => "trainings_users",
                          :foreign_key => "training_id",
                          :association_foreign_key => "user_id")

  # has_and_belongs_to_many(:members,
  #                        :join_table => "members_trainings",
  #                        :foreign_key => "training_id",
  #                        :association_foreign_key => "user_id")
end