class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.timestamps
      t.string :title
      t.string :user_id #allowed users enter here?
    end
    add_index :books, [:user_id, :created_at]
  end
end
