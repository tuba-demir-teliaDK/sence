class ChangeColumnTypeForPoint < ActiveRecord::Migration
  def up
    change_column_default(:profiles, :points, 0)
  end

  def down
  end
end
