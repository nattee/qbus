class AddLicenseToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :license_expire, :date
    add_column :applications, :contact_email, :string
  end
end
