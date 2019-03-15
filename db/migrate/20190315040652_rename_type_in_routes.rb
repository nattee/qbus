class RenameTypeInRoutes < ActiveRecord::Migration[5.2]
  def change
    change_table :routes do |t|
      t.rename :type, :route_type
    end
  end
end
