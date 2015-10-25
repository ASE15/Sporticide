class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  #has_many :trainings, foreign_key: "owner_id"
  has_and_belongs_to_many :trainings

  has_and_belongs_to_many(:friends,
                          :join_table => "friends",
                          :foreign_key => "user_a_id",
                          :association_foreign_key => "user_b_id")


  has_many :logs

end