class AddImpactAndCategoryId < ActiveRecord::Migration
  def change
    rename_column :questions, :rfi_id, :category_id
    add_column :questions, :impact, :string
  end
end
