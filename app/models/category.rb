class Category < ApplicationRecord
  validates :name, presence: true,
                   length: {in: 5..30 },
                   uniqueness: true
  validates :description, presence: true,
                          length: {in: 5..200}

end
