class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :opt1
      t.string :opt2
      t.integer :opt1_ac, :default=>0
      t.integer :opt2_ac, :default=>0

      t.timestamps
    end
  end
end
