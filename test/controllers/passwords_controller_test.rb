require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup { @user = User.take }

  test "new" do
    get new_password_path
    assert_response :success
  end

  test "create" do
    post passwords_path, params: { email_address: @user.email_address }
    assert_enqueued_email_with PasswordsMailer, :reset, args: [ @user ]
    assert_redirected_to new_session_path

    follow_redirect!
    assert_notice "reset instructions sent"
  end

  test "create for an unknown user redirects but sends no mail" do
    post passwords_path, params: { email_address: "missing-user@example.com" }
    assert_enqueued_emails 0
    assert_redirected_to new_session_path

    follow_redirect!
    assert_notice "reset instructions sent"
  end

  test "edit" do
    get edit_password_path(@user.password_reset_token)
    assert_response :success
  end

  test "edit with invalid password reset token" do
    get edit_password_path("invalid token")
    assert_redirected_to new_password_path

    follow_redirect!
    assert_notice "reset link is invalid"
  end

  test "update" do
    assert_changes -> { @user.reload.password_digest } do
      put password_path(@user.password_reset_token),
          params: { password: "a-long-password-1", password_confirmation: "a-long-password-1" }
      assert_redirected_to new_session_path
    end

    follow_redirect!
    assert_notice "Password has been reset"
  end

  test "update with non matching passwords" do
    token = @user.password_reset_token
    assert_no_changes -> { @user.reload.password_digest } do
      put password_path(token),
          params: { password: "a-long-password-1", password_confirmation: "something-else-1" }
      assert_redirected_to edit_password_path(token)
    end

    follow_redirect!
    assert_notice "Password confirmation"
  end

  test "update with a password that is too short" do
    token = @user.password_reset_token
    assert_no_changes -> { @user.reload.password_digest } do
      put password_path(token),
          params: { password: "short", password_confirmation: "short" }
      assert_redirected_to edit_password_path(token)
    end

    follow_redirect!
    assert_notice "minimum is #{User::MIN_PASSWORD_LENGTH} characters"
  end

  test "the reset link stops working after the password changes" do
    token = @user.password_reset_token
    put password_path(token),
        params: { password: "a-long-password-1", password_confirmation: "a-long-password-1" }

    get edit_password_path(token)
    assert_redirected_to new_password_path
  end

  test "the reset link stops working after it expires" do
    token = @user.password_reset_token

    travel_to (@user.password_reset_token_expires_in + 1.minute).from_now do
      get edit_password_path(token)
      assert_redirected_to new_password_path
    end
  end

  private
    def assert_notice(text)
      assert_select "div", /#{text}/
    end
end