class AddActiveToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :status, :integer
    add_index :questions, :user_id
    add_index :questions, :status, :default=>0
  end
end
