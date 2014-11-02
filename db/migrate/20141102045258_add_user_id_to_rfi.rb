class AddUserIdToRfi < ActiveRecord::Migration
  def change
  	add_column :rfis, :user_id, :integer
  end
end
