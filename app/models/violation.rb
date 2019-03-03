class Violation < ApplicationRecord
  belongs_to :car
  belongs_to :file
end
