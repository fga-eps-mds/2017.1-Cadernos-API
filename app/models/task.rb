class Task < ApplicationRecord
  belongs_to :category
  validates :title, presence: true,
    length:{in: 5..80}
  validates :user_id, presence: true
  validates :category_id, presence: true
end
