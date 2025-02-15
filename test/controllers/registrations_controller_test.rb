require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_params = {
      user: {
        email_address: "newuser@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }
    @invalid_params = {
      user: {
        email_address: "invaliduser@example.com",
        password: "password",
        password_confirmation: "mismatch"  # mismatched confirmation
      }
    }
    @existing_user = users(:one)  # from  users fixture
  end

  # Helper to sign in a user via posting to the session URL.
  def sign_in_as(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end

  test "should get new when not logged in" do
    get new_registrations_url
    assert_response :success
    # Verify the page includes a heading like "Sign up"
    assert_select "h1", /Sign up/i
  end

  test "should redirect new if already logged in" do
    sign_in_as(@existing_user)
    get new_registrations_url
    assert_redirected_to root_path
    assert_equal "You are already signed in.", flash[:alert]
  end

  test "should create user with valid credentials when not logged in" do
    assert_difference "User.count", 1 do
      post registrations_url, params: @valid_params
    end
    assert_redirected_to root_path
    assert_equal "Welcome! You have signed up successfully.", flash[:notice]
  end

  test "should not create user with invalid credentials" do
    assert_no_difference "User.count" do
      post registrations_url, params: @invalid_params
    end
    assert_response :unprocessable_entity
    # Check that the response includes an error message regarding password confirmation.
    assert_match /password confirmation.*match/i, @response.body
  end

  test "should redirect create if already logged in" do
    sign_in_as(@existing_user)
    post registrations_url, params: @valid_params
    assert_redirected_to root_path
    assert_equal "You are already signed in.", flash[:alert]
  end
end
