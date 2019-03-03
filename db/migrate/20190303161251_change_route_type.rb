class ChangeRouteType < ActiveRecord::Migration[5.2]
  def change
    remove_column :routes, :type, :string
    add_column :routes, :route_type, :string
  end
end
