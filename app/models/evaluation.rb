class Evaluation < ApplicationRecord
  belongs_to :application
  belongs_to :criterium
  belongs_to :evaluator, class_name: 'User'
end
