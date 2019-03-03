class CreateDatafiles < ActiveRecord::Migration[5.2]
  def change
    create_table :datafiles do |t|
      t.string :name
      t.date :month_year
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
