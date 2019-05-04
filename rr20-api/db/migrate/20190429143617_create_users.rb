class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, unique: true, null: false
      t.string :password

      t.timestamps
    end
  end
end
