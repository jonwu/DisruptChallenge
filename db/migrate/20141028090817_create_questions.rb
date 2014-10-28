class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :rfi
      t.boolean :qual
      t.boolean :quant
      t.string :category

      t.timestamps
    end
  end
end
