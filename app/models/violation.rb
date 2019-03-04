class Violation < ApplicationRecord
  belongs_to :car
  has_many :datafiles
end
