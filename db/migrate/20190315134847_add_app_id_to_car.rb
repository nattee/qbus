class AddAppIdToCar < ActiveRecord::Migration[5.2]
  def change
    add_reference :cars, :application, foreign_key: true
    remove_reference :cars, :route
    remove_reference :cars, :licensee
  end
end
