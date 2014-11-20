class CreateSubmission < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :collaborator_id 
      t.integer :response_id
      t.integer :score
      t.string :text
      t.integer :question_id

      t.timestamps
    end
  end
end
