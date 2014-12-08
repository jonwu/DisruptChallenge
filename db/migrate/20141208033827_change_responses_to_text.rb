class ChangeResponsesToText < ActiveRecord::Migration
  def change
    change_column :responses, :text, :text
  end
end
