class AddStatusStrToQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :status
    add_column :questions, :status, :string, :default=>'waiting_approval'
  end
end
