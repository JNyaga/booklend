require "test_helper"

class BooksShowViewTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
  end

  # Helper to sign in a user via posting to the session URL.
  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end

  test "show displays book details" do
    get book_url(@book)
    assert_select "h1", text: @book.title
    assert_select "p", text: "Author: #{@book.author}"
    assert_select "p", text: "Published: #{@book.first_publish_year}"
    assert_select "p", text: "ISBN: #{@book.isbn}"
  end

  test "show displays availability status" do
    get book_url(@book)
    assert_select "span", text: "✅ Available"
  end

  test "show displays borrow button for available book" do
    sign_in users(:one)
    get book_url(@book)
    assert_select "form button", text: "📖 Borrow this Book"
  end

  test "show displays return button only if the current user borrowed the book" do
    sign_in users(:one)

    # Ensure book is available before borrowing
    @book.update!(is_available: true)

    # Simulate borrowing by the current user
    users(:one).borrowings.create!(book: @book, borrowed_at: Time.now, due_date: 2.weeks.from_now)

    # Mark the book as unavailable after being borrowed
    @book.update!(is_available: false)

    # Visit the book's page
    get book_url(@book)

    # Check if the return button appears for this user
    assert_select "form button", text: "🔄 Return this Book"
  end

  test "show does not display return button if another user borrowed the book" do
    sign_in users(:two) # Different user logs in

    # Ensure the book is available before borrowing
    @book.update!(is_available: true)

    # Simulate borrowing by another user (user one)
    users(:one).borrowings.create!(book: @book, borrowed_at: Time.now, due_date: 2.weeks.from_now)

    # Mark the book as unavailable after being borrowed
    @book.update!(is_available: false)

    # Visit the book's page as user two
    get book_url(@book)

    # Ensure the return button is NOT displayed for user two
    assert_select "form button", text: "🔄 Return this Book", count: 0
  end
end