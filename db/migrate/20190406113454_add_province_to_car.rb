class AddProvinceToCar < ActiveRecord::Migration[5.2]
  def change
    add_column :cars, :province, :string
    add_column :cars, :brand, :string
    add_column :cars, :side_number, :string
  end
end
