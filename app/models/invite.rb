class Invite < ApplicationRecord
  belongs_to :book
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
  validate :check_user_redundancy, :check_user_is_already_member, :check_sender_is_allowed
  before_save :check_user_redundancy, :check_user_is_already_member, :check_sender_is_allowed

  validates :book, presence: true
  validates :sender, presence: true
  validates :recipient, presence: true

end

def check_user_redundancy
  if self.sender_id == self.recipient_id
    self.errors.add(:recipient, "can't be equal to sender")
  end
end

def check_user_is_already_member
  if self.book_id != nil
    @book = Book.find(self.book_id)
    if @book != nil
      if @book.members.find_by_member_id(self.recipient_id) != nil
        self.errors.add(:recipient, "is already a member")
      end
    end
  end
end

def check_sender_is_allowed
  if self.book_id != nil
    if Book.find(self.book_id) != nil
      if Book.find(self.book_id).user_id != self.sender_id
        self.errors.add(:sender, "is not book owner")
      end
    end
  end
end
