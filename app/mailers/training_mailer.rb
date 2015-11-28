class TrainingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.training_mailer.new_training.subject
  #
  def new_training(training,session,member)
    @training = training
    @session = session
    mail to: member.email, subject: "A new training session was created"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.training_mailer.edited_training.subject
  #
  def edited_training(training, session, member)
    @training = training
    @session = session

    mail to: member.email, subject: "A training session was updated"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.training_mailer.destroyed_training.subject
  #
  def destroyed_training(training, session, member)
    @training = training
    @session = session

    mail to: member.email, subject: "A training session was removed "
  end
end
