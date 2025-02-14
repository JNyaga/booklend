require "test_helper"

class SessionsViewTest < ActionDispatch::IntegrationTest
  test "sign in page renders correctly" do
    get new_session_url
    assert_response :success

    # Check for the main heading
    assert_select "h1", text: "Sign in"

    # Check for email field
    assert_select "input[name='email_address']" do |elements|
      assert_equal 1, elements.size, "There should be one email field"
    end

    # Check for password field
    assert_select "input[name='password']" do |elements|
      assert_equal 1, elements.size, "There should be one password field"
    end

    # Check for the submit button with "Sign in" value
    assert_select "input[type='submit'][value='Sign in']"

    # Check for the "Forgot password?" link
    assert_select "a[href=?]", new_password_path, text: /Forgot password\?/i

    # Check for the "Sign Up" link
    assert_select "a[href=?]", new_registrations_path, text: /Sign Up/i
  end
end
