class AddImpactToRfi < ActiveRecord::Migration
  def change
    add_column :rfis, :low, :integer
    add_column :rfis, :medium, :integer
    add_column :rfis, :high, :integer
  end
end
