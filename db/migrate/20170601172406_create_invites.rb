class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :book_id
      t.integer :recipient_id
      t.integer :sender_id
      t.timestamps
    end
    add_index :invites, [:book_id, :recipient_id, :sender_id]
  end
end
