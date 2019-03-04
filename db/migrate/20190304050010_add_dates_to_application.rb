class AddDatesToApplication < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :award_date, :datetime
    remove_column :applications, :evaluation_finish_date, :datetime
    add_column :applications, :confirmed_date, :datetime
    add_column :applications, :submitted_date, :datetime
    add_column :applications, :approved_date, :datetime
    add_column :applications, :awarded_date, :datetime
    add_column :applications, :evaluated_date, :datetime

    add_column :applications, :car_count, :integer
    add_column :applications, :trip_count, :integer

  end
end
