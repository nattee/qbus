class Datafile < ApplicationRecord
  belongs_to :user
  has_many :violation, :dependent => :destroy
end
