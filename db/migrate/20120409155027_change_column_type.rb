class ChangeColumnType < ActiveRecord::Migration
  def up
    change_column_default(:questions, :status, 'wapproval')
    add_index :answers, :question_id
    add_index :questions, :status
  end

  def down
  end
end
