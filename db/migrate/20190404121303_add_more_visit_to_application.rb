class AddMoreVisitToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :visitor, :string
    add_column :applications, :visitor_position, :string
    add_column :applications, :visitor_tel, :string
    add_column :applications, :visitor_email, :string
  end
end
