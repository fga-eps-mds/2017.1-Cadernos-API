class Book < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title,
            presence: true,
            length: {in: 5..70}
  has_many :invites
end
