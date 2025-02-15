require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = books(:one)
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = " "
    assert_not @book.valid?
  end

  test "author should be present" do
    @book.author = " "
    assert_not @book.valid?
  end

  test "isbn should be present" do
    @book.isbn = " "
    assert_not @book.valid?
  end

  test "isbn should be unique" do
    duplicate_book = @book.dup
    duplicate_book.isbn = @book.isbn
    @book.save
    assert_not duplicate_book.valid?
  end

  test "is_available should be true or false" do
    @book.is_available = nil
    assert_not @book.valid?
  end

  test "should have many borrowings" do
    assert @book.borrowings
  end
end
