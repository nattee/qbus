class AddProvinceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :province, :string, default: 'กท'
    add_column :users, :all_provinces, :boolean, default: false
  end
end
