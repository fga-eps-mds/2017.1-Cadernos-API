class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :book_id
      t.integer :recipient_id
      t.string :recipient_name
      t.integer :sender_id
      t.string :sender_name
      t.string :book_title
      t.timestamps
    end
    add_index :invites, [:book_id, :recipient_id, :sender_id]
  end
end
