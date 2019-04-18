require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "account_activation" do
    user = User.last()
    user.activation_token = User.new_token

    mail = UserMailer.account_activation(user)
    assert_equal "QBUS Account Activation", mail.subject
    assert_equal [User.last().email], mail.to
    assert_equal ["admin@qbusthailand.com"], mail.from
    # TODO assert mail's content
  end

  test "password_reset" do
    user = User.first()
    user.reset_token = User.new_token

    mail = UserMailer.password_reset(user)
    assert_equal "QBUS Password Reset", mail.subject
    assert_equal [User.first().email], mail.to
    assert_equal ["admin@qbusthailand.com"], mail.from
    # TODO assert mail's content
  end

end
