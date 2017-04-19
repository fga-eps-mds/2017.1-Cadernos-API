class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length:{in: 5..80}
  validates :email, confirmation: true, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email_confirmation, presence: true
  validates :password, presence: true, on: :create 
  has_many :books, dependent: :destroy

end
