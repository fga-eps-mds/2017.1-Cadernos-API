class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :category_id
      t.string :title
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
