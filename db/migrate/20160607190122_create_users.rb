class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :avatar_url
      t.string :default_address
      t.text :description

      t.timestamps null: false
    end
  end
end
