class AddContactToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :contact, :string
    add_column :applications, :contact_tel, :string
  end
end
