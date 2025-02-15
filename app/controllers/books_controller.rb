class BooksController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, only: %i[ index show ]
  before_action :require_authentication, except: %i[ index show]
  before_action :set_book, only: %i[show borrow return]


  def index
    if params[:query].present?
      # Downcase the search term in Ruby
      query = "%#{params[:query].downcase}%"
      # Use LOWER() to compare in lowercase
      @books = Book.where("LOWER(title) LIKE :query OR LOWER(author) LIKE :query OR LOWER(isbn) LIKE :query", query: query)
    else
      @books = Book.all
    end
  end

  def show
  end

  def borrow
    if @book.is_available?
      @borrowing = Current.user.borrowings.create!(
        book: @book,
        borrowed_at: Time.current,
        due_date: 2.weeks.from_now,
        returned: false
      )
      @book.update(is_available: false)
      redirect_to profile_path, notice: "You have borrowed '#{@book.title}'. "

    else
      redirect_to @book, alert: "This book is currently unavailable."
    end
  end

  def return
    @borrowing = Current.user.borrowings.find_by(book: @book, returned: false)

    if @borrowing
      @borrowing.update(returned: true)
      @book.update(is_available: true)
      redirect_to profile_path, notice: "You have returned '#{@book.title}'."
    else
      redirect_to book_path(@book), alert: "You have not borrowed this book."  # Ensure flash message is set
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
