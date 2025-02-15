require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  # Helper to sign in a user via posting to the session URL.
  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get show" do
    get book_url(@book)
    assert_response :success
  end

  test "should borrow book" do
    sign_in users(:one)
    post borrow_book_url(@book)
    assert_redirected_to profile_url
    follow_redirect!
    assert_match "You have borrowed", response.body
  end

  test "should return book" do
    sign_in users(:one)
    post borrow_book_url(@book)
    post return_book_url(@book)
    assert_redirected_to profile_url
    follow_redirect!
    assert_match "You have returned", response.body
  end

  test "should not borrow unavailable book" do
    sign_in users(:one)
    @book.update(is_available: false)
    post borrow_book_url(@book)
    assert_redirected_to book_url(@book)
    follow_redirect!
    assert_match "This book is currently unavailable", response.body
  end
end
