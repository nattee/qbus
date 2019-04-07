class Evaluation < ApplicationRecord
  belongs_to :application
  belongs_to :criterium
  belongs_to :evaluator, class_name: 'User', optional: true

  def is_main_evaluation?
    criterium.criteria_group.id <= 5

  end
end
