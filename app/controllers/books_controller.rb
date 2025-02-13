class BooksController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, only: %i[ index show ]
  before_action :require_authentication, except: %i[ index show]
  before_action :set_book, only: %i[show borrow return_book]


  def index
    @books = Book.all
  end

  def show
  end

  def borrow
    if @book.available?
      @borrowing = Current.user.borrowings.create!(
        book: @book,
        borrowed_at: Time.current,
        due_date: 2.weeks.from_now,
        returned: false
      )
      @book.update(available: false)
      redirect_to profile_path, notice: "You have borrowed '#{@book.title}'. "

    else
      redirect_to @book, alert: "This book is currently unavailable."
    end
  end

  def return_book
    @borrowing = Current.user.borrowings.find_by(book: @book, returned: false)

    if @borrowing
      @borrowing.update(returned: true)
      @book.update(available: true)
      redirect_to profile_path, notice: "You have returned '#{@book.title}'."
    else
      redirect_to @book, alert: "You have not borrowed this book."
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
