class RemoveLicenseExpireFromLicensees < ActiveRecord::Migration[5.2]
  def change
    remove_column :licensees, :license_expire, :date
    add_column :licensees, :contact_email, :string
  end
end
