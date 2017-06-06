class Inspiration < ApplicationRecord
  belongs_to :primary, :class_name => 'Book'
  belongs_to :inspirational, :class_name => 'Book'

  validates :primary, presence: true
  validates :inspirational, presence: true

end
