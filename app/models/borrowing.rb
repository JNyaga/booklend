class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :borrowed_at, :due_date, presence: true
  validate  :book_availability, on: :create

  private

  def book_availability
    errors.add(:book, "is already borrowed") unless book.available?
  end
end
