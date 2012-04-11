class AddPointToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :point, :integer, :default=>5

  end
end
