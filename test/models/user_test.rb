require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    # The email in the setup intentionally contains extra whitespace and uppercase letters
    # to test the normalization.
    @user = User.new(email_address: "  TEST@example.COM  ", password: "password")
  end

  test "should be valid with valid attributes" do
    assert @user.valid?, "User should be valid with proper attributes"
  end

  test "email should be present" do
    @user.email_address = "   "
    assert_not @user.valid?, "User should be invalid without an email address"
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save!
    assert_not duplicate_user.valid?, "Duplicate email should not be valid"
  end

  test "email should be normalized before saving" do
    @user.save!
    assert_equal "test@example.com", @user.email_address,
      "Email should be stripped of whitespace and downcased"
  end

  test "password should be present" do
    @user.password = " "
    assert_not @user.valid?, "User should be invalid without a password"
  end

  test "should authenticate with valid password" do
    @user.save!
    assert_equal @user, @user.authenticate("password"),
      "User should authenticate with the correct password"
  end

  test "should not authenticate with invalid password" do
    @user.save!
    assert_not @user.authenticate("wrongpassword"),
      "User authentication should fail with an incorrect password"
  end

  test "invalid email formats should be rejected" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_emails.each do |invalid_email|
      @user.email_address = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "valid email formats should be accepted" do
    valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
      @user.email_address = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end
end
