class CreateCriteria < ActiveRecord::Migration[5.2]
  def change
    create_table :criteria do |t|
      t.string :number
      t.string :name
      t.text :description
      t.text :approach
      t.integer :weight
      t.references :criteria_group

      t.timestamps
    end
  end
end
