class LocalUser < ActiveRecord::Base
  validates :plz, :length => { :is => 4 }, allow_nil: true
  has_many :trainings, foreign_key: "owner_id"
  has_many :training_notifiers, :inverse_of => :local_user, :dependent => :destroy
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

  def age_at(date, dob)
    if not date.nil? and not dob.nil?
      day_diff = date.day - dob.day
      month_diff = date.month - dob.month - (day_diff < 0 ? 1 : 0)
      date.year - dob.year - (month_diff < 0 ? 1 : 0)
    else
      'N/A'
    end
  end

  def get_name
    if (self.firstname.nil? and self.lastname.nil?) or (self.firstname.empty? and self.lastname.empty?)
      self.username
    else
      return "#{self.firstname} #{self.lastname}"
    end
  end
end