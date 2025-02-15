require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @book = books(:one)
    @borrowing = Borrowing.new(
      user: @user,
      book: @book,
      borrowed_at: Time.current,
      due_date: 2.weeks.from_now,
      returned: false
    )
  end

  test "should be valid with valid attributes" do
    assert @borrowing.valid?
  end

  test "should require a user" do
    @borrowing.user = nil
    assert_not @borrowing.valid?
  end

  test "should require a book" do
    @borrowing.book = nil
    assert_not @borrowing.valid?
  end

  test "should require borrowed_at" do
    @borrowing.borrowed_at = nil
    assert_not @borrowing.valid?
  end

  test "should require due_date" do
    @borrowing.due_date = nil
    assert_not @borrowing.valid?
  end

  test "should not allow borrowing if book is not available" do
    @book.update(is_available: false)
    assert_not @borrowing.valid?
    assert_includes @borrowing.errors[:book], "is already borrowed"
  end

  test "should allow borrowing if book is available" do
    @book.update(is_available: true)
    assert @borrowing.valid?
  end
end
