class RemoveCategory < ActiveRecord::Migration
  def change
    remove_column :questions, :category
  end
end
