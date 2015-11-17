class TrainingMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.training_mailer.new_training.subject
  #
  def new_training(member)
    mail to: member.email, subject: "new training created"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.training_mailer.edited_training.subject
  #
  def edited_training(training)
    @training = training

    mail to: "to@example.org", subject: ""
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.training_mailer.destroyed_training.subject
  #
  def destroyed_training(training)
    @training = training

    mail to: "to@example.org", subject: ""
  end
end
