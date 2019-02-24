class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :number
      t.references :user
      t.integer :state
      t.references :licensee
      t.references :route
      t.string :category
      t.datetime :appointment_date
      t.text :appointment_remark
      t.references :appointment_user
      t.datetime :evaluation_finish_date
      t.datetime :award_date
      t.text :award
      t.text :award_remark

      t.timestamps
    end
  end
end
