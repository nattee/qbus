class Route < ApplicationRecord
  has_many :cars
  has_many :applications
end
