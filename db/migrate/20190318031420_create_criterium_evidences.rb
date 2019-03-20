class CreateCriteriumEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :criteria_evidences do |t|
      t.references :criterium, foreign_key: true
      t.references :evidence, foreign_key: true

      t.timestamps
    end
  end
end
