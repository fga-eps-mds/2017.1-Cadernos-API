class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :nome
      t.string :email
      t.string :password_digest
      t.string :matricula

      t.timestamps
    end
  end
end
