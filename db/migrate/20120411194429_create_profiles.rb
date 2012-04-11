class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :nickname
      t.float :points

      t.timestamps
    end
  end
end
