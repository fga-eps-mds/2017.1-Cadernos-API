class Membership < ApplicationRecord
  belongs_to :book
  belongs_to :member, :class_name => 'User'

  validates :book, presence: true
  validates :member, presence: true
end
