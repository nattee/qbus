class CreateViolations < ActiveRecord::Migration[5.2]
  def change
    create_table :violations do |t|
      t.references :car, foreign_key: true
      t.integer :count
      t.date :month_year
      t.references :datafile, foreign_key: true

      t.timestamps
    end
  end
end
