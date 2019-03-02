class Criterium < ApplicationRecord
  belongs_to :criteria_group
  has_many :evaluations
end
