class FixBookUserReference < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :user_id
    add_reference :books, :user, foreign_key: true
  end
end
