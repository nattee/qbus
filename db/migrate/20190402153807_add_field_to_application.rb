class AddFieldToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :award_won, :boolean
    add_column :applications, :visited_date, :datetime
    add_column :applications, :visited, :boolean
  end
end
