class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.timestamps
      t.string :title
      t.references :user, foreign_key: true
      t.string :task_list
    end
  end
end
