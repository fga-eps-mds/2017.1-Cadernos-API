class CreateInspirations < ActiveRecord::Migration[5.0]
  def change
    create_table :inspirations do |t|
        t.integer :primary_id
        t.string :primary_title
        t.integer :inspirational_id
        t.string :inspirational_title
      t.timestamps
    end
      add_index :inspirations, [:primary_id, :inspirational_id]
  end
end
