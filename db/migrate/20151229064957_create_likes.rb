class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :counter
      t.references :idea, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
