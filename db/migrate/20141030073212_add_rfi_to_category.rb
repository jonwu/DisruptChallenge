class AddRfiToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :rfi_id, :integer
  end
end
