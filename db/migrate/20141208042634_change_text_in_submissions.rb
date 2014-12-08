class ChangeTextInSubmissions < ActiveRecord::Migration
  def change
    change_column :submissions, :text, :text
  end
end
