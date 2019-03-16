class AddLicenseNoToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :license_no, :string
  end
end
