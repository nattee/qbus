class ChangeCategoryInApplication < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications, :category, :string
    add_column :applications, :category, :integer
  end

end
