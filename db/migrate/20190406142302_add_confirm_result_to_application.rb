class AddConfirmResultToApplication < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :register_result, :string
    add_column :applications, :visited_confirm_date, :datetime
    add_column :applications, :confirm_result, :boolean
    add_column :applications, :confirm_comment, :string
  end
end
