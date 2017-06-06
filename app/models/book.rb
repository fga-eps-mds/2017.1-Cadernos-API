class Book < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title,
            presence: true,
            length: {in: 5..70}

  has_many :invites
  has_many :members, :class_name => 'Membership', :foreign_key => 'book_id'

  has_many :inspirational_books, :class_name => 'Inspiration', :foreign_key => 'book_id'

  has_attached_file :cover,
                    styles: {medium: "240x120", thumb: "80x40"},
                    content_type: /\Aimage/,
                    default_url: "/images/:style/missing.jpg",
                    default_style: "medium"

  validates_attachment :cover
  do_not_validate_attachment_file_type :cover

  attr_accessor :cover_base
  before_validation :parse_image

  def cover_original
    self.cover.url(:original)
  end

  def cover_medium
    self.cover.url(:medium)
  end

  def cover_thumb
    self.cover.url(:thumb)
  end

  private
    def parse_image
      if cover_base
        image = Paperclip.io_adapters.for(cover_base)
        image.original_filename = "file.jpg"
        self.cover = image
      end
    end

end
