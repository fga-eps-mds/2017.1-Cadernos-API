class Category < ApplicationRecord
  has_many :tasks
  validates :name, presence: true,
                   length: {in: 5..30 },
                   uniqueness: true

  validates :description, length: {maximum: 200}

  def self.BASE_CATEGORIES
    ["Criação", "Experimento", "Teórico"]
  end
end
