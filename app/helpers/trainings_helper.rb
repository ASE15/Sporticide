module TrainingsHelper

  def is_own_training?(training)
    training.user == current_user
  end

end
