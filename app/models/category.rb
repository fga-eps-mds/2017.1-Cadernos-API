class Category < ApplicationRecord
  validates :name, presence: true, length:{in:5..80}
  validates :description, presence: true, length:{in:5..200}

end
