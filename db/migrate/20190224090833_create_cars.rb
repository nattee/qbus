class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :plate
      t.string :chassis
      t.references :licensse
      t.references :route
      t.date :last_accident
      t.text :last_accident_desc
      t.string :type

      t.timestamps
    end
  end
end
