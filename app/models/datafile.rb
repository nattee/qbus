class Datafile < ApplicationRecord
  belongs_to :user
  belongs_to :violation
end
