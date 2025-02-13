class Book < ApplicationRecord
  has_many :borrowings, dependent: :destroy

  validates :title, presence: true
  validates :author_name, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :is_available, inclusion: { in: [ true, false ] }

  def as_json(options = {})
    super(options).merge({
      key: id.to_s
    })
  end
end
