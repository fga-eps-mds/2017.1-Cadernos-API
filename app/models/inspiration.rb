class Inspiration < ApplicationRecord

  validates_uniqueness_of :primary_id, scope: [:inspirational_id]
  belongs_to :primary, :class_name => 'Book'
  belongs_to :inspirational, :class_name => 'Book'

  validates :primary, presence: true
  validates :inspirational, presence: true
  validate :primary_cannot_be_inspirational

end

def primary_cannot_be_inspirational
  if primary_id == inspirational_id
    errors.add(:primary_id, "primary can't be same as inspirational")
  end
end
