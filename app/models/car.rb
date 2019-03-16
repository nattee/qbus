class Car < ApplicationRecord
  #belongs_to :route, optional: true
  #belongs_to :route, optional: true
  #belongs_to :licensee, optional: true
  belongs_to :application, optional: true
  has_many :violations, :dependent => :nullify
end
