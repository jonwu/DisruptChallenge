class RenameCollaboratorsToVendors < ActiveRecord::Migration
  def change
    rename_table :collaborators, :vendors
  end
end
