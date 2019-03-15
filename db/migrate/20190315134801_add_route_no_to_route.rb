class AddRouteNoToRoute < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :route_no, :string
  end
end
