class AddColumnFileList < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :files_list, :integer
  end
end
