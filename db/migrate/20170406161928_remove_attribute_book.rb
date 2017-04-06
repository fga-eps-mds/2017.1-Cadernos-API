class RemoveAttributeBook < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :task_list
  end
end
