class TrainingSession < ActiveRecord::Base
  belongs_to :training
  has_many :logs, :inverse_of => :training_session, :dependent => :destroy

  def user_already_logged?(user)
    self.logs.each do |l|
      if l.user == user
        return true
      end
    end
    return false
  end
end
