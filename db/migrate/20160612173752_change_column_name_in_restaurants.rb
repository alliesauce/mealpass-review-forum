class ChangeColumnNameInRestaurants < ActiveRecord::Migration
  def change
    rename_column :restaurants, :address, :raw_address
  end
end
