class AddServiceAreaToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :service_area, :string
  end
end
