class Book < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :user_id, presence: true
  validates :title,
            presence: true,
            length: {in: 5..70}
end
