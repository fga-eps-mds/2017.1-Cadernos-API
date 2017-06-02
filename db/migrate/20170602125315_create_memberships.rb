class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.string :email
      t.integer :book_id
      t.integer :member_id
      t.timestamps
    end
  end
end
