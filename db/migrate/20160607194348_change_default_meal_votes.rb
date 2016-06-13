class ChangeDefaultMealVotes < ActiveRecord::Migration
  def change
    change_column_default(:meals, :vote_count, 0)
  end
end
