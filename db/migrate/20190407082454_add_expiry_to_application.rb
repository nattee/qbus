class AddExpiryToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :award_expire_date, :datetime
    add_column :applications, :extend, :boolean, default: false
    add_reference :applications, :extend_app
  end
end
