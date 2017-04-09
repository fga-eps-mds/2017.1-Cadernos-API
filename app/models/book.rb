class Book < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title,
            presence: true,
            length: {in: 5..70}
end
