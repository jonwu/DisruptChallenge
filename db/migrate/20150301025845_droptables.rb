class Droptables < ActiveRecord::Migration
  def change
  	drop_table :comments
  	drop_table :answers
  end
end
