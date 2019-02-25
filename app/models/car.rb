class Car < ApplicationRecord
  belongs_to :route, optional: true
end
