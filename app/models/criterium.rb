class Criterium < ApplicationRecord
  belongs_to :criteria_group
  has_many :evaluations

  scope :need_evaluation, -> {joins(:criteria_group).where('criteria_groups.id <= 6')}

  has_and_belongs_to_many :evidences

  def number_text
    return "#{criteria_group.id}.#{id}"
  end
end
