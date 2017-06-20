class Task < ApplicationRecord
  belongs_to :book
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length:{in: 5..80}
  validates :content, presence: true

  validate :taskCreationPermission

  before_save :parse_image, :taskCreationPermission

  attr_accessor :picture_base

  has_attached_file :picture,
    styles: { medium: "500x500>", thumb: "200x200>" }, default_style: "medium", default_url: "/images/:style/missing.jpg"
    validates_attachment :picture
    do_not_validate_attachment_file_type :picture

  def picture_original
    self.picture.url(:original)
  end

  def picture_medium
    self.picture.url(:medium)
  end

  def picture_thumb
    self.picture.url(:thumb)
  end

  def taskCreationPermission
    if self.book_id != nil
      if Book.find(self.book_id) != nil
        unless Book.find(self.book_id).user_id == self.user_id
          @membership = Membership.find_by_book_id(self.book_id)
          if @membership != nil
            unless Book.find(self.book_id).members.all.include(Membership.find_by_member_id(self.user_id))
              self.errors.add(:user, "is not allowed to create a task")
            end
          else
            self.errors.add(:user, "is not allowed to create a task")
          end
        end
      end
    end
  end

  private
    def parse_image
      if picture_base
        image = Paperclip.io_adapters.for(picture_base)
        image.original_filename = self.id + ".jpg"
        self.picture = image
      end
    end

end
