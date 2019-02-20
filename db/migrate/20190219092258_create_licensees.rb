class CreateLicensees < ActiveRecord::Migration[5.2]
  def change
    create_table :licensees do |t|
      t.string :name
      t.string :license_no
      t.date :license_expire
      t.string :car_count
      t.string :contact
      t.string :contact_tel

      t.timestamps
    end
  end
end
