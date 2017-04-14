class Task < ApplicationRecord
  belongs_to :book
  validates :title, presence: true,
  length:{in: 5..80}
  validates :book_id, presence: true
  validates :content, presence: true

  has_many :documents
  has_many :images

  attr_accessor :document_data
  attr_accessor :image_data


  def save_file(params)
    params[:document_data].each do |doc|
      self.documents.create(:file => doc)
    end
  end

  def save_image(params)
    params[:image_data].each do |image|
      self.images.create(:picture => image)
    end
  end
end
