class Renameanswers < ActiveRecord::Migration
  def change
  	rename_table :answers, :replies
  end
end
