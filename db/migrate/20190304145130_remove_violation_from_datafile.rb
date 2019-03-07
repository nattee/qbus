class RemoveViolationFromDatafile < ActiveRecord::Migration[5.2]
  def change
    remove_reference :datafiles, :violation
  end
end
