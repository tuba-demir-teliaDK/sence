class RemoveColumnFromUser < ActiveRecord::Migration
  def up
    remove_column :questions, :user_id
    add_column :questions, :user_id, :integer
  end

  def down
  end
end
