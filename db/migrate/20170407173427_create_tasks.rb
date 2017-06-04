class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :category_id
      t.string :title
      t.text :content
      t.integer :user_id
      t.references :book, index: true, foreign_key: true
      t.timestamps
    end
    add_index :tasks, [:book_id, :created_at]
    add_index :tasks, [:user_id, :created_at]
  end
end
