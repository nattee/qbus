class FixCarLicensee < ActiveRecord::Migration[5.2]
  def change
    change_table :cars do |t|
      t.rename :licensse_id, :licensee_id
    end
  end
end
