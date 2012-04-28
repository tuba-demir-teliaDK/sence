class AddUniqueIndexToAnswersOverQu < ActiveRecord::Migration
  def change
    add_index :answers, [:question_id,:user_id], :unique => true
  end
end
