class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.text :description
      t.integer :vote_count
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
