# Preview all emails at http://localhost:3000/rails/mailers/training_mailer
class TrainingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/training_mailer/new_training
  def new_training
    training = Training.last
    TrainingMailer.new_training(training)
  end

  # Preview this email at http://localhost:3000/rails/mailers/training_mailer/edited_training
  def edited_training
    training = Training.last
    TrainingMailer.edited_training(training)
  end

  # Preview this email at http://localhost:3000/rails/mailers/training_mailer/destroyed_training
  def destroyed_training
    training = Training.last
    TrainingMailer.destroyed_training(training)
  end

end
