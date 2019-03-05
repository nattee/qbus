class AddResultsToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :register_result, :text
    add_column :applications, :evaluation_result, :text
  end
end
