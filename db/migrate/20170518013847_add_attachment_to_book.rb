class AddAttachmentToBook < ActiveRecord::Migration[5.0]
  def up
    add_attachment :books, :cover
  end

  def down
    remove_attachment :books, :cover
  end
end
