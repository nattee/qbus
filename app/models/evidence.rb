class Evidence < ApplicationRecord
  has_and_belongs_to_many :criteria

  def first_cri_num
    "#{criteria.first.criteria_group.id}.#{criteria.first.number}"
  end

end
