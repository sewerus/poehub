class ChangeRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :title, :string
    remove_column :roles, :resource_id
    remove_column :roles, :resource_type
  end
end
