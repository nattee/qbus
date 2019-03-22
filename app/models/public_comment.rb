class PublicComment < ApplicationRecord
  belongs_to :route
  belongs_to :car
  belongs_to :licensee
end
