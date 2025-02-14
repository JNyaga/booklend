require "test_helper"

# Override after_authentication_url in SessionsController for tests.
SessionsController.class_eval do
  def after_authentication_url
    root_path
  end
end

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # your fixture user
  end

  # Helper method to sign in via session POST.
  def sign_in_as(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end

  test "should get new when not logged in" do
    get new_session_url
    assert_response :success
    assert_select "h1", /Sign in/
  end

  # test "should redirect new if already logged in" do
  #   # Simulate a logged-in user by setting Current.session.
  #   Current.session = OpenStruct.new(user: @user)
  #   get new_session_url
  #   assert_redirected_to root_path
  #   assert_equal "You are already signed in.", flash[:alert]
  # ensure
  #   Current.reset
  # end

  test "should create session with valid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_redirected_to root_path
    assert_equal "Welcome! You have signed in successfully.", flash[:notice]
  end

  test "should not create session with invalid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "wrongpassword" }
    assert_redirected_to new_session_path
    assert_equal "Try another email address or password.", flash[:alert]
  end

  test "should destroy session" do
    sign_in_as(@user)
    delete session_url
    assert_redirected_to new_session_path
    assert_equal "You have been signed out.", flash[:notice]
  end
end
