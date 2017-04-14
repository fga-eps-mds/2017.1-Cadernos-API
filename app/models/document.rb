class Document < ApplicationRecord
  belongs_to :task
  has_attached_file :file
  validates_attachment :file
  do_not_validate_attachment_file_type :file
end
