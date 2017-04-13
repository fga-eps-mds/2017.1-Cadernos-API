class Category < ApplicationRecord
  validates :name, presence: true, length:{5..80}
  validates :description, presence: true, length:{5..200}

end
