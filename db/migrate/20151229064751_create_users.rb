class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :alias
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.integer :post_counter
      t.integer :like_counter

      t.timestamps null: false
    end
  end
end
