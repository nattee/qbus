class Criterium < ApplicationRecord
  belongs_to :criteria_group
  has_many :evaluations

  has_and_belongs_to_many :evidences
end
