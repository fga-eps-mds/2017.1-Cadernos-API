class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :email_confirmation
      t.string :password_digest

      t.timestamps
    end
  end
end
