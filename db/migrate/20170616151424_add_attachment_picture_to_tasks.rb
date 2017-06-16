class AddAttachmentPictureToTasks < ActiveRecord::Migration
  def self.up
    change_table :tasks do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :tasks, :picture
  end
end
