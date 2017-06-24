class AddAvatarToUser < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.attachment :avatar
    end
  end
end
