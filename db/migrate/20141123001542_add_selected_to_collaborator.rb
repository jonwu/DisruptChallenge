class AddSelectedToCollaborator < ActiveRecord::Migration
  def change
    add_column :collaborators, :selected, :boolean, :default => true
  end
end
