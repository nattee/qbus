class CreateCriteriaGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :criteria_groups do |t|
      t.string :name
      t.integer :group_weight

      t.timestamps
    end
  end
end
