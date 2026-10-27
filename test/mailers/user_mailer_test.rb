require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome" do
    user = users(:one)
    mail = UserMailer.welcome(user)

    assert_match "Wheelhouse", mail.subject
    assert_equal [ user.email_address ], mail.to
    assert_match user.email_address, mail.body.encoded
  end
end