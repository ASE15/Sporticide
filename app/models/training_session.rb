class TrainingSession < ActiveRecord::Base
  belongs_to :training
  has_many :logs, :inverse_of => :training_session, :dependent => :destroy
end
