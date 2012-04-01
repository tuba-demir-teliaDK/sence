class AddAppleIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :apple_id, :string
  end
end
