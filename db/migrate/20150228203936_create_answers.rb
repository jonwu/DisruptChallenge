class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.integer :user_id
      t.integer :comment_id
    end
  end
end
