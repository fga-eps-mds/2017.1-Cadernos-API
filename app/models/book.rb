class Book < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title,
            presence: true,
            length: {in: 5..70}

  has_attached_file :cover,
                    styles: {medium: "240x120", thumb: "80x40"},
                    content_type: /\Aimage/,
                    default_url: "/images/:style/missing.jpg"

  validates_attachment :cover
  do_not_validate_attachment_file_type :cover

  attr_accessor :cover_base
  before_validation :parse_image

  private
    def parse_image
      if cover_base
        image = Paperclip.io_adapters.for(cover_base)
        image.original_filename = "file.jpg"
        self.cover = image
      end
    end
end
