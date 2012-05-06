class RemoveUniqueIndexOnQuestions < ActiveRecord::Migration
  def up
    remove_index :questions, "opt1_and_opt2"
  end

  def down
  end
end
