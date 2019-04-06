class CriteriaGroup < ApplicationRecord
  has_many :criterium

  scope :need_evidence, -> {where('id <= 5')}

  def name_trim
    return 'ด้านองค์กร' if id == 1
    return 'ด้านความปลอดภัย' if id == 5
    return name[8..]
  end
end
