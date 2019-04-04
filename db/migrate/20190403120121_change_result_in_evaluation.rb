class ChangeResultInEvaluation < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluations, :result, :boolean
    remove_column :evaluations, :evaluator, :string
    add_column :evaluations, :result, :float
    add_column :evaluations, :evaluator_id, :integer
  end
end
