class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.integer :id_category
      t.string :title
      t.text :content
      t.integer :id_user

      t.timestamps
    end
  end
end
