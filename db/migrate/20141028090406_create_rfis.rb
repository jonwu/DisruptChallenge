class CreateRfis < ActiveRecord::Migration
  def change
    create_table :rfis do |t|

      t.timestamps
    end
  end
end
