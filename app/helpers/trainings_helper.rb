module TrainingsHelper

  def is_own_training?(training)
    training.owner == current_user
  end

end
