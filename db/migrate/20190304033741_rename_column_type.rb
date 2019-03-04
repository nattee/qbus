class RenameColumnType < ActiveRecord::Migration[5.2]
  def change
    change_table :cars do |t|
      t.rename :type, :car_type
    end
    change_table :routes do |t|
      t.rename :type, :route_type
    end
  end
end
