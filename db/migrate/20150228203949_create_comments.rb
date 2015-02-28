class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :user_id
      t.integer :question_id
    end
  end
end
