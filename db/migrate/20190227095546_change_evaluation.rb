class ChangeEvaluation < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluations, :criteria_id, :integer
    add_reference :evaluations, :criterium, index: true
  end
end
