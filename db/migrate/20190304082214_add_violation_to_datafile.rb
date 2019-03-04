class AddViolationToDatafile < ActiveRecord::Migration[5.2]
  def change
    add_reference :datafiles, :violation, index: true
  end
end
