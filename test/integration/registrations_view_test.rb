require "test_helper"

class RegistrationsViewTest < ActionDispatch::IntegrationTest
  test "registration page renders correctly" do
    get new_registrations_url
    assert_response :success

    # Check the main heading "Sign up"
    assert_select "h1", text: "Sign up"

    # Check the descriptive paragraph is present
    assert_select "p", /Create your account to start accessing books\./i


    # Check for the email field
    assert_select "input[name='user[email_address]'][type='email']"

    # Check for the password field
    assert_select "input[name='user[password]'][type='password']"

    # Check for the password confirmation field
    assert_select "input[name='user[password_confirmation]'][type='password']"

    # Check for the submit button with the value "Sign up"
    assert_select "input[type='submit'][value='Sign up']"

    # Check for the "Forgot password?" link pointing to new_password_path
    assert_select "a[href='#{new_password_path}']", /Forgot password\?/i

    # Check for the "Sign in" link pointing to new_session_path
    assert_select "a[href='#{new_session_path}']", /Sign in/i
  end
end
