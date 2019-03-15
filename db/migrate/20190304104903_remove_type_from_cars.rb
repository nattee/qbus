class RemoveTypeFromCars < ActiveRecord::Migration[5.2]
  def change
    change_table :cars do |t|
      t.rename :type, :car_type
    end
  end
end
