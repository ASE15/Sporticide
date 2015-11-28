require 'test_helper'

class TrainingMailerTest < ActionMailer::TestCase
  test "new_training" do
    mail = TrainingMailer.new_training
    assert_equal "New training", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "edited_training" do
    mail = TrainingMailer.edited_training
    assert_equal "Edited training", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "destroyed_training" do
    mail = TrainingMailer.destroyed_training
    assert_equal "Destroyed training", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
