class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.references :application, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
