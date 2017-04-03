class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 15}
  validates :description, presence: true, length: {maximum: 200}

end
