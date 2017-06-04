class Book < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title,
            presence: true,
            length: {in: 5..70}
  has_many :invites
  has_many :members, :class_name => 'Membership', :foreign_key => 'member_id'
end
