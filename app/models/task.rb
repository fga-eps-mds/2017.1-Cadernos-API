class Task < ApplicationRecord
  belongs_to :category
  validates :title, presence: true
  validates :user_id, presence: true
end
