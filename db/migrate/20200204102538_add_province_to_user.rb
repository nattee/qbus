class AddProvinceToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :province, :string, default: 'กท'
    add_column :users, :limit_province, :boolean, default: true
  end
end
