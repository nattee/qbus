class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :application
      t.references :criteria
      t.string :evaluator
      t.date :evaluation_date
      t.boolean :result
      t.text :description

      t.timestamps
    end
  end
end
