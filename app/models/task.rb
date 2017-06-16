class Task < ApplicationRecord
  belongs_to :book
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length:{in: 5..80}
  validates :content, presence: true

  before_save :parse_image

  attr_accessor :picture_base

  has_attached_file :picture,
    styles: { medium: "500x500>", thumb: "200x200>" }, default_style: "medium", default_url: "/images/:style/missing.jpg"
    validates_attachment :picture
    do_not_validate_attachment_file_type :picture

  private
    def parse_image
      if picture_base
        image = Paperclip.io_adapters.for(picture_base)
        image.original_filename = "file.jpg"
        self.picture = image
      end
    end

end
