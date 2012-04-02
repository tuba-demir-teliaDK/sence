class AddStatusnewToQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :status
    add_column :questions, :status, :integer, :default=>0
  end
end
