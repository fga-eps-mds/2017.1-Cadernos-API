class Task < ApplicationRecord
  belongs_to :book
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length:{in: 5..80}
  validates :content, presence: true
end
