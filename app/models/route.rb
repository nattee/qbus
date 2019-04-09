class Route < ApplicationRecord
  has_many :cars
  has_many :applications

  validates :route_no, presence: true
end
