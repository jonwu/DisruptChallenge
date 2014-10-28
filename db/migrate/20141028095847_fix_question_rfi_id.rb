class FixQuestionRfiId < ActiveRecord::Migration
  def change
    rename_column :questions, :rfi, :rfi_id
  end
end
