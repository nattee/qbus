class RemoveTypeFromCars < ActiveRecord::Migration[5.2]
  def change
    remove_column :cars, :type, :integer
  end
end
