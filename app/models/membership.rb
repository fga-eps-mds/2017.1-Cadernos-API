class Membership < ApplicationRecord
  belongs_to :book
  belongs_to :member, :class_name => 'User'

  validates :book, presence: true
  validates :member, presence: true

  validates_uniqueness_of :member_id, scope: [:book_id]
end
