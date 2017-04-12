class Task < ApplicationRecord
  belongs_to :book
  validates :title, presence: true,
  length:{in: 5..80}
  validates :book_id, presence: true
  validates :content, presence: true
end
