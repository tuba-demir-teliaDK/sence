class AddUniqueIndexToQuestions < ActiveRecord::Migration
  def change
    add_index :questions, [:opt1,:opt2], :unique => true
  end
end
