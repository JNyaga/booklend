require "test_helper"

class BooksIndexViewTest < ActionDispatch::IntegrationTest
  test "index displays all books" do
    get books_url
    assert_select "h2", text: "📚 All Books"
    assert_select "ul.grid li", count: Book.count
  end

  test "index displays no books message" do
    Borrowing.delete_all  # Ensure no foreign key constraints are violated
    Book.delete_all
    get books_url
    assert_select "p", text: "No books available at the moment."
  end
end
