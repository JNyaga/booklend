require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # using fixtures, named :one.
    @user = users(:one)
  end

  test "should redirect if not authenticated" do
    # Attempt to access the profile page without signing in
    get profile_url
    # Expect a redirect, to the sign-in page
    assert_redirected_to new_session_path
    # check a flash message or status
    assert_equal "You must be logged in to access this page", flash[:alert]
  end

  test "should get profile if authenticated" do
    # Sign in the user
    sign_in_as @user

    get profile_url
    assert_response :success
    # check the template  content
    assert_select "h1", "Your Borrowed Books"
  end

  private

  # helper method to sign in a user
  def sign_in_as(user)
    post session_url, params: {
      email_address: user.email_address,
      password: "password" # Or a known fixture password
    }
  end
end
