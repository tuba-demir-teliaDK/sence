class RemoveColumnFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :user_id
    add_column :users, :user_id
  end

  def down
  end
end
