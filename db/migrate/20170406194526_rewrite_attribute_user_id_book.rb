class RewriteAttributeUserIdBook < ActiveRecord::Migration[5.0]
  def change
    change_column :books, :user_id, :integer
  end
end
