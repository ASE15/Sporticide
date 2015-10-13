class Training < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', :inverse_of => :logs, :dependent => :destroy
  has_many :trainingsessions, :inverse_of => :training, :dependent => :destroy
  has_many :comments, :inverse_of => :training, :dependent => :destroy

  has_and_belongs_to_many(:members,
                          :join_table => "members_trainings",
                          :foreign_key => "training_id",
                          :association_foreign_key => "user_id")
end