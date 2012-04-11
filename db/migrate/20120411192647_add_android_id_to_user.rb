class AddAndroidIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :android_id, :string

  end
end
