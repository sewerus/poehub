class RepairRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :resource_type, :string
    add_column :roles, :resource_id, :integer
    add_index(:roles, [ :name, :resource_type, :resource_id ])
  end
end
