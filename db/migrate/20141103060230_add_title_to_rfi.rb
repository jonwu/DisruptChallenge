class AddTitleToRfi < ActiveRecord::Migration
  def change
    add_column :rfis, :title, :string
  end
end
