class AddRfiIdToCollaborator < ActiveRecord::Migration
  def change
    add_column :collaborators, :rfi_id, :integer
  end
end
