class Car < ApplicationRecord
  belongs_to :route, optional: true
  belongs_to :licensee, optional: true
end
