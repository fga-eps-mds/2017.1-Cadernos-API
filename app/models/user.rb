class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length:{in: 5..80}
  validates :email, confirmation: true, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email_confirmation, presence: true

  has_many :invitations, :class_name => 'Invite', :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => 'Invite', :foreign_key => 'sender_id'
  has_many :memberships, :class_name => 'Membership', :foreign_key => 'member_id'

  validates :password, length:{in: 6..80}, presence: true, on: :create
  has_many :books, dependent: :destroy
  has_many :tasks

  before_save :parse_image

  attr_accessor :avatar_base
  has_attached_file :avatar,
                    styles: { medium: "500x500>", thumb: "200x200>" },
                    default_style: "medium",
                    default_url: "/images/:style/default-avatar.jpg"

  validates_attachment :avatar
  do_not_validate_attachment_file_type :avatar

  def avatar_original
    self.avatar.url(:original)
  end

  def avatar_medium
    self.avatar.url(:medium)
  end

  def avatar_thumb
    self.avatar.url(:thumb)
  end

  private
    def parse_image
      if avatar_base
        image = Paperclip.io_adapters.for(avatar_base)
        image.original_filename = "file.jpg"
        self.avatar = image
      end
    end

end
