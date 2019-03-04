class Car < ApplicationRecord
  belongs_to :route, optional: true
  belongs_to :licensee, optional: true
  has_many :violations
end
