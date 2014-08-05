class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :to
      t.string :from
      t.text :question
      t.boolean :answer
      t.boolean :answerd

      t.timestamps
    end
  end
end
