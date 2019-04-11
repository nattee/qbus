require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = User.last()
    user.activation_token = "testtest"

    mail = UserMailer.account_activation(user)
    assert_equal "QBUS Account Activation", mail.subject
    assert_equal [User.first().email], mail.to
    assert_equal ["nattee@nattee.net"], mail.from
    #TODO: the email is base64 encoded; not sure how to extract content
    assert_match "base64", mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset(User.first())
    assert_equal "QBUS Password Reset", mail.subject
    assert_equal [User.first().email], mail.to
    assert_equal ["nattee@nattee.net"], mail.from
    assert_match "find me", mail.body.encoded
  end

end
